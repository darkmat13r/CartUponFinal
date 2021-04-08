import 'dart:async';

import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/product/product_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductVariant.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ProductController extends BaseController {
  List<ProductDetail> similarProducts = [];
  ProductDetail product;

  ProductPresenter _presenter;

  ProductVariantValue selectedProductVariant;

  ProductController(this.product, ProductRepository productRepository)
      : _presenter = ProductPresenter(product, productRepository);

  String elapsedTime;

  @override
  void initListeners() {
    showLoading();
    _presenter.getProductOnNext = (details) {
      this.product = details;
      refreshUI();
    };
    _presenter.getProductOnComplete = () {
      dismissLoading();
    };
    _presenter.getProductOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getContext(), e.message, isError: true);
    };
    _presenter.getSimilarProductOnNext = (similarProducts) {
      this.similarProducts = similarProducts;
      refreshUI();
    };
    _presenter.getSimilarProductOnComplete = () {
      dismissLoading();
    };
    _presenter.getSimilarProductOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getContext(), e.message, isError: true);
    };
  }


  void search(String categoryId){
    AppRouter().categorySearchById(getContext(), categoryId);
  }

  onSelectVariant(ProductVariantValue variantValue){
    this.selectedProductVariant = variantValue;
    showGenericSnackbar(getContext(), "Variant Seleected");
    refreshUI();

  }

  void reviews() {
    Navigator.of(getContext()).pushNamed(Pages.reviews);
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }
}
