import 'package:coupon_app/app/pages/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class OrderController extends Controller{
  @override
  void initListeners() {
  }

  void product(){
    Navigator.of(getContext()).pushNamed(Pages.product);
  }
}