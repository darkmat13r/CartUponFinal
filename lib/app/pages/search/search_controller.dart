import 'package:coupon_app/app/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SearchController extends Controller{
  @override
  void initListeners() {
  }

  void product(){
    Navigator.of(getContext()).pushNamed(Pages.product);
  }
}