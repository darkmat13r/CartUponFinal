import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/explore/explore_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/models/CategoryType.dart';
import 'package:coupon_app/domain/repositories/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ExploreController extends BaseController{
  ExplorePresenter _presenter;

  List<CategoryType> categories = [ ];

  ExploreController(CategoryRepository categoryRepo) : _presenter = ExplorePresenter(categoryRepo){
    showLoading();
  }

  @override
  void initListeners() {
    _presenter.getCategoryOnNext = getCategoryOnNext;
    _presenter.getCategoryOnError = getCategoryOnError;
    _presenter.getCategoryOnComplete = getCategoryOnComplete;
  }



  getCategoryOnNext(List<CategoryType> response) {
    this.categories = response;
    refreshUI();
  }

  getCategoryOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message);
  }

  getCategoryOnComplete() {
    dismissLoading();
  }
  void search(CategoryType category){
    AppRouter().categorySearch(getContext(), category);
  }
}