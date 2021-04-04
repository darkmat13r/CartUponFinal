import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/coupons/coupons_presenter.dart';
import 'package:coupon_app/app/pages/product/product_view.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/dummy.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/category_entity.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:coupon_app/domain/repositories/category_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CouponsController extends BaseController{

  CouponPresenter _presenter;

  List<CategoryEntity> categories = [ ];

  List<ProductEntity> products = DummyProducts.products();


  CouponsController(CategoryRepository couponCategoryRepository) : _presenter = CouponPresenter(couponCategoryRepository){

  }

  @override
  void initListeners() {
    _presenter.getCategoryOnNext = getCouponCategoryOnNext;
    _presenter.getCategoryOnError = getCouponCategoryOnError;
    _presenter.getCategoryOnComplete = getCouponCategoryOnComplete;
  }

  void search(CategoryEntity category){
    AppRouter().categorySearch(getContext(), category);
  }

  getCouponCategoryOnNext(List<CategoryEntity> response) {
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