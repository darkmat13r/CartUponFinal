import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class WelcomeController extends Controller{
  @override
  void initListeners() {
  }

  void joinNow() {

  }

  void skip(){
    Navigator.of(getContext()).pushNamed('/home');
  }

}