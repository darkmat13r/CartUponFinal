import 'package:coupon_app/app/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ExploreController extends Controller{

  @override
  void initListeners() {
  }

  void search(){
    Navigator.of(getContext()).pushNamed(Pages.search);
  }
}