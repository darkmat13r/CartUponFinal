import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/coupons/coupons_presenter.dart';
import 'package:coupon_app/app/pages/product/product_view.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/dummy.dart';
import 'package:coupon_app/domain/entities/category_entity.dart';
import 'package:coupon_app/domain/entities/coupons/category_detail_entity.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:coupon_app/domain/repositories/coupon/category_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CouponsController extends BaseController{

  CouponPresenter _presenter;

  List<CategoryDetailEntity> categories = [ ];

  List<ProductEntity> products = DummyProducts.products();


  CouponsController(CouponCategoryRepository couponCategoryRepository) : _presenter = CouponPresenter(couponCategoryRepository){

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
}