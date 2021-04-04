import 'dart:async';

import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
import 'package:coupon_app/app/utils/dummy.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ProductController extends Controller{

  List<ProductEntity> similarProducts = DummyProducts.products();
  ProductEntity product;


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
          product.productId != null &&
          product.productId.validTo != null;
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
            DateTime.now(), product.productId.validTo);
      });
    }
  }
}
