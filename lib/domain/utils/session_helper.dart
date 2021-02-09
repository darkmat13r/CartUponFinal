import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/domain/entities/user_entity.dart';

class SessionHelper {
  /// Singleton object of `DataAuthenticationRepository`
  static SessionHelper _instance = SessionHelper._internal();
  Logger _logger;

  // Constructors
  SessionHelper._internal() {
    _logger = Logger('DataAuthenticationRepository');
  }

  factory SessionHelper() => _instance;

  /// Returns the current authenticated `User` from `SharedPreferences`.
  Future<UserEntity> getCurrentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserEntity user = UserEntity()
        .fromJson(jsonDecode(preferences.getString(Constants.userKey)));
    return user;
  }

  /// Saves the [token] and the [user] in `SharedPreferences`.
  void saveCredentials(
      {@required String token, @required UserEntity user}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await Future.wait([
        preferences.setString(Constants.tokenKey, token),
        preferences.setBool(Constants.isAuthenticatedKey, true),
        preferences.setString(Constants.userKey, jsonEncode(user))
      ]);
      _logger.finest('Credentials successfully stored.');
    } catch (error) {
      _logger.warning('Credentials could not be stored.');
    }
  }
}
