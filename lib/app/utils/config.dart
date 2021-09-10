import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/WebSetting.dart';
import 'package:flutter/material.dart';

class Config {

  Locale locale;
  WebSetting webSettings;

  static Config _instance = Config._internal();

  Country selectedCountry;

  Config._internal(){

  }

  factory Config() => _instance;

  getLanguageId() {
    return locale != null && locale.languageCode.contains('en') ? 0 : 1;
  }
}