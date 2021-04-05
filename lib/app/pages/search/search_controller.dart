import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/search/search_presenter.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/models/CategoryType.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SearchController extends BaseController{
  List<ProductDetail> coupons = [];

  SearchPresenter _presenter;



  SearchController(ProductRepository couponRepository, {CategoryType category }) : _presenter = SearchPresenter(couponRepository){
    showLoading();
    _presenter.searchCouponCategory(category);
  }

  @override
  void initListeners() {
    _presenter.getCouponsOnNext = getCouponsOnNext;
    _presenter.getCouponsOnError = getCouponsOnError;
    _presenter.getCouponsOnComplete = getCouponsOnComplete;
  }




  void product(){
    Navigator.of(getContext()).pushNamed(Pages.product);
  }

  void filter() {
    Navigator.of(getContext()).pushNamed(Pages.filter);
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  getCouponsOnNext(List<ProductDetail> products) {
    this.coupons = products;
    refreshUI();
  }

  getCouponsOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message);
    print(e);

  }

  getCouponsOnComplete() {
    dismissLoading();
  }
}