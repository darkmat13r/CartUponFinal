import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/explore/explore_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/category_entity.dart';
import 'package:coupon_app/domain/entities/coupons/category_detail_entity.dart';
import 'package:coupon_app/domain/repositories/coupon/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ExploreController extends BaseController{
  ExplorePresenter _presenter;

  List<CategoryDetailEntity> categories = [ ];

  ExploreController(CouponCategoryRepository couponCategoryRepository) : _presenter = ExplorePresenter(couponCategoryRepository){
    showLoading();
  }

  @override
  void initListeners() {
    _presenter.getCouponCategoryOnNext = getCouponCategoryOnNext;
    _presenter.getCouponCategoryOnError = getCouponCategoryOnError;
    _presenter.getCouponCategoryOnComplete = getCouponCategoryOnComplete;
  }



  getCouponCategoryOnNext(List<CategoryDetailEntity> response) {
    this.categories = response;
    refreshUI();
  }

  getCouponCategoryOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message);
  }

  getCouponCategoryOnComplete() {
    dismissLoading();
  }
  void search(CategoryDetailEntity category){
    AppRouter().categorySearch(getContext(), category);
  }
}