import 'dart:async';
import 'dart:io';
import 'package:coupon_app/app/utils/auth_state_stream.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:flutter/foundation.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/domain/entities/user_entity.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logging/logging.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';

/// `DataAuthenticationRepository` is the implementation of `AuthenticationRepository` present
/// in the Domain layer. It communicates with the server, making API calls to register, login, logout, and
/// store a `User`.
class DataAuthenticationRepository implements AuthenticationRepository {
  // Members
  /// Singleton object of `DataAuthenticationRepository`
  static DataAuthenticationRepository _instance =
      DataAuthenticationRepository._internal();
  Logger _logger;

  // Constructors
  DataAuthenticationRepository._internal() {
    _logger = Logger('DataAuthenticationRepository');
  }

  factory DataAuthenticationRepository() => _instance;

  /// Logs in a `User` using a [email] and a [password] by making an API call to the server.
  /// It is asynchronous and can throw an `APIException` if the statusCode is not 200.
  /// When successful, it attempts to save the credentials of the `User` to local storage by
  /// calling [_saveCredentials]. Throws an `Exception` if an Internet connection cannot be
  /// established. Throws a `ClientException` if the http object fails.
  Future<Customer> authenticate(
      {@required String email, @required String password}) async {
    try {
      String oldUserId = await SessionHelper().getUserId();
      // invoke http request to login and convert body to map
      Map<String, dynamic> body = await HttpHelper.invokeHttp(
          Constants.loginRoute, RequestType.post,
          body: {'username': email, 'password': password});
      _logger.finest('Login Successful.' + body.toString());

      // convert json to User and save credentials in local storage
      Customer user = Customer.fromJson(body);
      SessionHelper().saveCredentials(token: user.key, user: user);

      AuthStateStream().notifyLoggedIn(user);
      try {
        await HttpHelper.invokeHttp(Constants.changeCartUserIdRoute, RequestType.post,
            body: {'olduser_id': oldUserId.toString(), 'newuser_id': user.user.id.toString()});
      } catch (e) {}
      return user;
    } catch (error) {
      rethrow;
    }
  }

  /// Returns whether the current `User` is authenticated.
  Future<bool> isAuthenticated() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool isAuthenticated = preferences.getBool(Constants.isAuthenticatedKey);
      return isAuthenticated ?? false;
    } catch (error) {
      return false;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await HttpHelper.invokeHttp(
          Constants.forgotPasswordRoute, RequestType.post,
          body: {'email': email});
    } catch (error) {
      _logger.warning('Could not send reset password request.', error);
      rethrow;
    }
  }

  /// Logs the current `User` out by clearing credentials.
  Future<void> logout() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove(Constants.isAuthenticatedKey);
      preferences.remove(Constants.tokenKey);
      preferences.remove(Constants.userKey);
      _logger.finest('Logout successful.');
    } catch (error) {
      _logger.warning('Could not log out.', error);
    }
  }

  @override
  Future<Customer> getCurrentUser() {
    return SessionHelper().getCurrentUser();
  }

  @override
  Future<Customer> register({
    String firstName,
    String lastName,
    String username,
    String email,
    String countryCode,
    String mobileNo,
    String dateOfBirth,
    String isActive,
    String password,
    String nationality,
    String gender,
    String title,
  }) async {
    try {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.connectionHeader: "keep-alive",
      };
      String oldUserId = await SessionHelper().getUserId();
      Map<String, dynamic> body =
          await HttpHelper.invokeHttp(Constants.registerRoute, RequestType.post,
              headers: headers,
              body: jsonEncode({
                'country_code': countryCode,
                'date_of_birth': dateOfBirth,
                'nationlity': nationality,
                'title': title,
                'user': {
                  'first_name': firstName,
                  'last_name': lastName,
                  'username': mobileNo,
                  'email': email,
                  'password': password,
                  'is_active': "1",
                }
              }));

      Customer token = Customer.fromJson(body);
      SessionHelper().saveCredentials(token: token.token, user: token);
      AuthStateStream().notifyLoggedIn(token);
      try {
       await HttpHelper.invokeHttp(Constants.changeCartUserIdRoute, RequestType.post,
            body: {'olduser_id': oldUserId.toString(), 'newuser_id': token.user.id.toString()});
      } catch (e) {}
      _logger.finest('Registration is successful');
      return token;
    } catch (error) {
      _logger.warning('Could not register new user.', error);
      rethrow;
    }
  }

  @override
  Future<Customer> getProfile() async {
    try {
      Customer currentUser = await getCurrentUser();

      if (currentUser != null) {
        var uri = "${Constants.registerRoute}${currentUser.user.id}/";
        Map<String, dynamic> profileData = await HttpHelper.invokeHttp(
          uri,
          RequestType.get,
          headers: {
            HttpHeaders.authorizationHeader:
                "Token ${(await SessionHelper().getToken())}"
          },
        );

        if (profileData['user'] != null) {
          Customer token = Customer.fromJson(profileData);
          SessionHelper().updateUser(user: token);
          return token;
        }
      }
      return await SessionHelper().getCurrentUser();
    } catch (error) {
      _logger.warning('Could not get profile request.', error);
      rethrow;
    }
  }

  @override
  Future<Customer> update(
      {String firstName,
      String lastName,
      String username,
      String email,
      String countryCode,
      String gender,
      String nationality,
      String title,
      String mobileNo,
      String dateOfBirth,
      String isActive}) async {
    try {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.connectionHeader: "keep-alive",
      };
      Customer currentUser = await getCurrentUser();
      Map<String, dynamic> body = await HttpHelper.invokeHttp(
          "${Constants.registerRoute}${currentUser.user.id}/",
          RequestType.patch,
          headers: headers,
          body: jsonEncode({
            'date_of_birth': dateOfBirth,
            'gender': gender,
            'nationlity': nationality,
            'title': title,
            'user': {
              'first_name': firstName,
              'last_name': lastName,
            }
          }));
      Customer token = Customer.fromJson(body);
      SessionHelper().updateUser(user: token);
      _logger.finest('Update is successful');
      return token;
    } catch (error) {
      _logger.warning('Could not Update user.', error);
      rethrow;
    }
  }

  @override
  Future<Customer> updatePassword(
      {String password, String current, String passwordRepeat}) async {
    try {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.connectionHeader: "keep-alive",
      };
      Customer currentUser = await getCurrentUser();
      Map<String, dynamic> body = await HttpHelper.invokeHttp(
          "${Constants.changePasswordRoute}", RequestType.post,
          body: {
            'old_password': current,
            'new_password1': password,
            'new_password2': passwordRepeat
          });
      Customer token = Customer.fromJson(body);
      SessionHelper().updateUser(user: token);
      _logger.finest('Update is successful');
      return token;
    } catch (error) {
      _logger.warning('Could not Update user.', error);
      rethrow;
    }
  }

  @override
  Future<Customer> authenticateFacebook({String accessToken}) async {
    try {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.connectionHeader: "keep-alive",
      };
      Map<String, dynamic> body = await HttpHelper.invokeHttp(
          Constants.registerRoute, RequestType.post,
          headers: headers, body: {"token": accessToken});
      Customer token = Customer.fromJson(body);
      SessionHelper().saveCredentials(token: token.token, user: token);
      _logger.finest('Registration is successful');
      return token;
    } catch (error) {
      _logger.warning('Could not register new user.', error);
      rethrow;
    }
  }
}
