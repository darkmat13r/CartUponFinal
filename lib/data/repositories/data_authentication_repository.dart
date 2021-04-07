import 'dart:async';
import 'dart:io';
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

  // AuthenticationRepository Methods

  /* /// Registers a `User` using a [email] and a [password] by making an API call to the server.
  /// It is asynchronous and can throw an `APIException` if the statusCode is not 200.
  Future<void> register(
      {@required String fullName,
      @required String email,
      @required String password}) async {
    try {
      Map<String, dynamic> body =await HttpHelper.invokeHttp(Constants.registerRoute, RequestType.post,
          body: {
            'fullName': fullName,
            'username': email,
            'password': password,
          });
      Token user = Token.fromJson(body);
      SessionHelper().saveCredentials(token: user.key, user: user);
      _logger.finest('Registration is successful');

    } catch (error) {
      _logger.warning('Could not register new user.', error);
      rethrow;
    }
  }*/

  /// Logs in a `User` using a [email] and a [password] by making an API call to the server.
  /// It is asynchronous and can throw an `APIException` if the statusCode is not 200.
  /// When successful, it attempts to save the credentials of the `User` to local storage by
  /// calling [_saveCredentials]. Throws an `Exception` if an Internet connection cannot be
  /// established. Throws a `ClientException` if the http object fails.
  Future<Token> authenticate(
      {@required String email, @required String password}) async {
    try {
      // invoke http request to login and convert body to map
      Map<String, dynamic> body = await HttpHelper.invokeHttp(
          Constants.loginRoute, RequestType.post,
          body: {'username': email, 'password': password});
      _logger.finest('Login Successful.' + body.toString());

      // convert json to User and save credentials in local storage
      Token user = Token.fromJson(body);
      SessionHelper().saveCredentials(token: user.key, user: user);
      return user;
    } catch (error) {
      _logger.warning(error.message);
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
  Future<Token> getCurrentUser() {
    return SessionHelper().getCurrentUser();
  }

  @override
  Future<Token> register(
      {String firstName,
      String lastName,
      String username,
      String email,
      String countryCode,
      String mobileNo,
      String dateOfBirth,
      String isActive,
      String password}) async {
    try {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.connectionHeader: "keep-alive",

      };
      Map<String, dynamic> body =
         await HttpHelper.invokeHttp(Constants.registerRoute, RequestType.post,
              headers: headers,
              body: jsonEncode({
                'country_code': countryCode,
                'mobile_no': mobileNo,
                'date_of_birth': dateOfBirth,
                'user': {
                  'first_name': firstName,
                  'last_name': lastName,
                  'username': email,
                  'email': email,
                  'password': password,
                  'is_active': 1,
                }
              }));
      Token token = Token.fromJson(body);
      SessionHelper().saveCredentials(token: token.key, user: token);
      _logger.finest('Registration is successful');
      return token;
    } catch (error) {
      _logger.warning('Could not register new user.', error);
      rethrow;
    }
  }
}
