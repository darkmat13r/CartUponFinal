import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/product/product_presenter.dart';
import 'package:coupon_app/app/pages/home/listing/main_listing_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/models/Adbanner.dart';
import 'package:coupon_app/domain/entities/models/BannerSlider.dart';
import 'package:coupon_app/domain/entities/models/HomeData.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/banners/slider_repository.dart';
import 'package:coupon_app/domain/repositories/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
class MainListingController extends BaseController{
  List<ProductDetail> products = [];

  MainListingPresenter _presenter;

  Logger _logger;

  HomeData homeResponse;


  MainListingController(HomeRepository homeRepo, AuthenticationRepository authRepo) : _presenter = MainListingPresenter(homeRepo, authRepo){
    _logger = Logger();

  }

  @override
  void initListeners() {
    _presenter.getHomePageOnNext = getHomeOnNext;
    _presenter.getHomePageOnError = getHomeOnError;
    _presenter.getHomePageOnComplete = getHomeOnComplete;
    initBaseListeners(_presenter);
    showLoading();
  }

  void search(String categoryId) {
    AppRouter().categorySearchById(getContext(), categoryId);
  }

  login(){
    Navigator.of(getContext()).pushNamed(Pages.login);
  }
  register(){
    Navigator.of(getContext()).pop();
    Navigator.of(getContext()).pushNamed(Pages.requestOtp);
  }

  getHomeOnNext(HomeData res) {
    var itemsToRemove = [];
    res.sections.forEach((element) {
      if(element.category.products == null || element.category.products.length == 0){
        itemsToRemove.add(element);
      }
    });
    itemsToRemove.forEach((element) {
      res.sections.remove(element);
    });
    this.homeResponse = res;
    refreshUI();
  }

  getHomeOnError(NoSuchMethodError e) {
    dismissLoading();
    _logger.e(e);
    showGenericSnackbar(getContext(), e.toString());
  }

  getHomeOnComplete() {
    dismissLoading();
  }

  openLink(String link){
    var parts = split(link );
    _logger.e(parts[parts.length-1]);
    if(parts.length > 0){
      AppRouter().productDetailsById(getContext(), parts[parts.length-1]);
    }else{
      showGenericSnackbar(getContext(), LocaleKeys.invalidLink.tr(), isError: true);
    }
  }

  onClickSlider(BannerSlider slider){
    openLink(slider.banner_link);
  }
  onClickBanner(Adbanner banner){
    openLink(banner.banner_link);
  }
  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }
}