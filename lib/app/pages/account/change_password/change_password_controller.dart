import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ChangePasswordController extends Controller{
  @override
  void initListeners() {
  }

  void save() {
    Navigator.of(getContext()).pop();
  }
}