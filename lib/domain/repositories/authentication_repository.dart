import 'dart:async';

import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:flutter/foundation.dart';
import 'package:coupon_app/domain/entities/user_entity.dart';

/// A repository tasked with user authentication and registration.
abstract class AuthenticationRepository {
  /// Registers a new user using the provided [username] and [password]
  Future<void> register(
      {
      @required String fullName,
        @required String email,
      @required String password});

  /// Authenticates a user using his [username] and [password]
  Future<Token> authenticate(
      {@required String email, @required String password});

  /// Returns whether the [UserEntity] is authenticated.
  Future<bool> isAuthenticated();

  /// Returns the current authenticated [UserEntity].
  Future<Token> getCurrentUser();



  /// Resets the password of a [UserEntity]
  Future<void> forgotPassword(String email);

  /// Logs out the [UserEntity]
  Future<void> logout();
}
