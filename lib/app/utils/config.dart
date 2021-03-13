import 'package:flutter/material.dart';

class Config {

  Locale locale;

  static Config _instance = Config._internal();

  Config._internal(){

  }

  factory Config() => _instance;
}