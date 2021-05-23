import 'dart:convert';
import 'dart:io';

import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:device_info/device_info.dart';
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
  Future<Token> getCurrentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String json = preferences.getString(Constants.userKey);
    if (json != null) {
      Token user = Token.fromJson(jsonDecode(json));
      return user;
    }
    return null;
  }

  void updateUser({@required Token user}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await Future.wait([
        preferences.setBool(Constants.isAuthenticatedKey, true),
        preferences.setString(Constants.userKey, jsonEncode(user))
      ]);
      _logger.finest('Credentials successfully stored.');
    } catch (error) {
      _logger.warning('Credentials could not be stored.');
    }
  }

  /// Saves the [token] and the [user] in `SharedPreferences`.
  void saveCredentials({@required String token, @required Token user}) async {
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

  getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(Constants.tokenKey);
    return token;
  }

  getTempId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(Constants.tempIdKey);
  }

  /// Saves the [token] and the [user] in `SharedPreferences`.
  void saveTempId({@required int tempId}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await Future.wait([
        preferences.setInt(Constants.tempIdKey, tempId),
      ]);
    } catch (error) {
      _logger.warning('TempId could not be stored.');
    }
  }

  getUserId() async {
    Token token = await getCurrentUser();
    if (token == null || token.user == null) {
      var tempId = await getTempId();
      if (tempId == null || tempId == 0 || tempId == -1) {
        tempId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        await saveTempId(tempId: tempId);
      }
      return tempId.toString();
    }
    return token.user.id.toString();
  }

  Future<int> lastShownPopup() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String date = await preferences.getString(Constants.lastLoginPopupShownKey);
    if (date != null) {
      return DateTime.now().difference(DateFormat.yMd().parse(date)).inDays;
    }
    return 0;
  }

  void updateLastShownPopup() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(Constants.lastLoginPopupShownKey,
        DateFormat.yMd().format(DateTime.now()));
  }
}
