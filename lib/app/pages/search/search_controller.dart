import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/search/search_presenter.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/models/CategoryType.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/repositories/category_repository.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SearchController extends BaseController {
  List<ProductDetail> products = [];

  SearchPresenter _presenter;

  CategoryType categoryType;
  String query;

  SearchController(
      ProductRepository productRepo, CategoryRepository categoryRepo,
      {this.categoryType, String categoryId, this.query})
      : _presenter = SearchPresenter(productRepo, categoryRepo) {
    showLoading();
    if (categoryType != null)
      _presenter.searchCategory(categoryType);
    else if (categoryId != null) {
      _presenter.searchCategoryById(categoryId);
    } if(query  != null){
      _presenter.searchByQuery(query);
  } else{
     /* showGenericSnackbar(getContext(), LocaleKeys.errorInvalidCategory.tr(),
          isError: true);*/
    }
  }

  @override
  void initListeners() {
    _presenter.getProductsOnNext = getProductsOnNext;
    _presenter.getProductsOnError = getProductsOnError;
    _presenter.getProductsOnComplete = getProductsOnComplete;

    _presenter.getCategoryOnNext = (categoryType){
      dismissLoading();
      this.categoryType = categoryType;
    };

    _presenter.getCategoryOnError = (e){
      //showGenericSnackbar(getContext(), e.message, isError: true);
    };
    _presenter.getCategoryOnComplete = (){
      dismissLoading();
    };
  }

  void product() {
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

  getProductsOnNext(List<ProductDetail> products) {
    this.products = products;
    refreshUI();
  }

  getProductsOnError(e) {
    dismissLoading();

    showGenericSnackbar(getContext(), e.message);
  }

  getProductsOnComplete() {
    dismissLoading();
  }
}
