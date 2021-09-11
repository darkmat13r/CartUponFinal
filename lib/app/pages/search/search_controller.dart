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
import 'package:logger/logger.dart';

class Filter {
  String key;
  String value;

  Filter(this.key, this.value);
}

class SearchController extends BaseController {
  List<ProductDetail> products = [];

  final filters = [
    Filter("low-price", LocaleKeys.sortLowPrice.tr()),
    Filter("high-price", LocaleKeys.sortHighPrice.tr()),
    Filter("new", LocaleKeys.sortNew.tr()),
    Filter("best-offer", LocaleKeys.sortBestOffer.tr())
  ];

  Filter selectedFilter;
  SearchPresenter _presenter;

  CategoryType categoryType;
  String categoryId;
  String query;

  SearchController(
      ProductRepository productRepo, CategoryRepository categoryRepo,
      {this.categoryType, this.categoryId, this.query})
      : _presenter = SearchPresenter(productRepo, categoryRepo) {
    fetch();
  }

  fetch() {
    showLoading();
    if (categoryId != null) {
      _presenter.searchCategoryById(categoryId,
          filter: selectedFilter != null ? selectedFilter.key : null);
    } else if (categoryType != null)
      _presenter.searchCategory(categoryType,
          filter: selectedFilter != null ? selectedFilter.key : null);
    else if (query != null) {
      _presenter.searchByQuery(query,
          filter: selectedFilter != null ? selectedFilter.key : null);
    } else {
      /* showGenericSnackbar(getContext(), LocaleKeys.errorInvalidCategory.tr(),
          isError: true);*/
    }
  }

  @override
  void initListeners() {
    _presenter.getProductsOnNext = getProductsOnNext;
    _presenter.getProductsOnError = getProductsOnError;
    _presenter.getProductsOnComplete = getProductsOnComplete;

    _presenter.getCategoryOnNext = (categoryType) {
      dismissLoading();
      this.categoryType = categoryType;
    };

    _presenter.getCategoryOnError = (e) {
      //showGenericSnackbar(getContext(), e.message, isError: true);
    };
    _presenter.getCategoryOnComplete = () {
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

  void setFilter(Filter value) {
    selectedFilter = value;
    refreshUI();
    fetch();
  }
}
