import 'dart:async';

import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:flutter/foundation.dart';
import 'package:coupon_app/domain/entities/user_entity.dart';

/// A repository tasked with user authentication and registration.
abstract class AuthenticationRepository {
  /// Registers a new user using the provided [username] and [password]
  Future<Customer> register(
      {@required String firstName,
      @required String lastName,
      @required String username,
      @required String email,
      @required String countryCode,
      @required int countryId,
      @required String mobileNo,
      @required String dateOfBirth,
      @required String isActive,
      @required String nationality,
      @required String gender,
      @required String title,
      @required String password});

  /// Authenticates a user using his [username] and [password]
  Future<Customer> authenticate(
      {@required String email, @required String password});

  Future<Customer> authenticateFacebook({@required String accessToken});

  Future<Customer> authenticateGoogle({@required String accessToken});

  /// Returns whether the [UserEntity] is authenticated.
  Future<bool> isAuthenticated();

  /// Returns the current authenticated [UserEntity].
  Future<Customer> getCurrentUser();

  Future<Customer> getProfile();

  /// Resets the password of a [UserEntity]
  Future<void> forgotPassword(String email);

  /// Logs out the [UserEntity]
  Future<void> logout();

  Future<Customer> update(
      {String firstName,
      String lastName,
      String username,
      String email,
      String nationality,
      String gender,
      int country,
      String title,
      String countryCode,
      String mobileNo,
      String dateOfBirth,
      String isActive});

  Future<Customer> updatePassword(
      {String current, String password, String passwordRepeat});
}
