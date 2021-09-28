import 'dart:convert';
import 'dart:io';

import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
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
  Future<Customer> getCurrentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String json = preferences.getString(Constants.userKey);
    if (json != null) {
      Customer user = Customer.fromJson(jsonDecode(json));
      return user;
    }
    return null;
  }

  void updateUser({@required Customer user}) async {
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
  void saveCredentials({@required String token, @required Customer user}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if(token !=  null){
       await preferences.setString(Constants.tokenKey, token);
      }
      await Future.wait([
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
    Customer token = await getCurrentUser();
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
  Future<bool> isPopupShown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isShown = await preferences.getBool(Constants.isLoginPopupShownKey);
    return isShown ?? false;
  }
  void setShownPopup() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(Constants.isLoginPopupShownKey,
       true);
  }

  void updateLastShownPopup() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(Constants.lastLoginPopupShownKey,
        DateFormat.yMd().format(DateTime.now()));
  }

  Future<List<Country>> cachedCounties() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String countiesJson =
        await preferences.getString(Constants.cachedCountiesKey);
    if (countiesJson != null) {
      try {
        List<dynamic> countries = jsonDecode(countiesJson);
        return countries.map((e) => Country.fromJson(e)).toList();
      } catch (e) {}
    }
    return null;
  }

  Future<Country> getSelectedCountry() async{
    List<Country> countries = await cachedCounties();
    try{
      var selectedId = await getSelectedCountryId();

      Country country =  countries.firstWhere((element) => element.id == selectedId);
      if(country != null){
        return country;
      }

    }catch(e){

    }
    return countries.first;
  }

  void cacheCounties( List<Country> list) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(Constants.cachedCountiesKey, jsonEncode(list));
  }


  Future<int> getSelectedCountryId() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int id = await preferences.getInt(Constants.selectCountryId);
    return id;
  }

  void setSelectedCountryId(int id) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(Constants.selectCountryId,id);
  }


  Future<Locale> getLanguage() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = await preferences.getString(Constants.selectedLanguage) ;
    return id  != null ? Locale(id) : null;
  }

  void setSelectedLanguage(String languageCode) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(Constants.selectedLanguage,languageCode);
  }
}
