import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/dummy.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SearchController extends Controller{
  List<ProductEntity> products = DummyProducts.products();

  @override
  void initListeners() {
  }

  void product(){
    Navigator.of(getContext()).pushNamed(Pages.product);
  }

  void filter() {
    Navigator.of(getContext()).pushNamed(Pages.filter);
  }
}