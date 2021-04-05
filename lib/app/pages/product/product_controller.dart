import 'dart:async';

import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ProductController extends Controller{

  List<ProductDetail> similarProducts = [];
  ProductDetail product;


  ProductController(this.product);

  String elapsedTime;

  @override
  void initListeners() {
  }

  void reviews(){
    Navigator.of(getContext()).pushNamed(Pages.reviews);
  }

  Timer _timer;
  bool _isValidToValid() =>
      product != null &&
          product.product != null &&
          product.product.valid_to != null;
  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }



  _createTimer() {
    if (_isValidToValid()) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        elapsedTime = DateHelper.formatExpiry(
            DateTime.now(), product.product.valid_to);
      });
    }
  }
}
