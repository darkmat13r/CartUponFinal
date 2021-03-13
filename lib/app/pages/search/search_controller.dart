import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/search/search_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/dummy.dart';
import 'package:coupon_app/domain/entities/coupons/category_detail_entity.dart';
import 'package:coupon_app/domain/entities/coupons/coupon_entity.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:coupon_app/domain/repositories/coupon/coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SearchController extends BaseController{
  List<CouponEntity> coupons = [];

  SearchPresenter _presenter;


  SearchController(CouponRepository couponRepository, {CategoryDetailEntity couponCategory }) : _presenter = SearchPresenter(couponRepository){
    showLoading();
    _presenter.searchCouponCategory(couponCategory);
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
  void onDisposed(BuildContext context) {
    _presenter.dispose();
    super.onDisposed(context);
  }

  getCouponsOnNext(List<CouponEntity> coupons) {
    this.coupons = coupons;
    refreshUI();
  }

  getCouponsOnError(e) {
    dismissLoading();
    print(e.stackTrace.toString());
    showGenericSnackbar(getContext(), e.message);
  }

  getCouponsOnComplete() {
    dismissLoading();
  }
}