import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/product/product_presenter.dart';
import 'package:coupon_app/app/pages/products/products_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/dummy.dart';
import 'package:coupon_app/domain/entities/home/home_entity.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:coupon_app/domain/repositories/banners/slider_repository.dart';
import 'package:coupon_app/domain/repositories/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
import 'package:coupon_app/domain/entities/slider_banner_entity.dart';
class ProductsController extends BaseController{
  List<ProductEntity> products = DummyProducts.products();

  ProductsPresenter _presenter;

  Logger _logger;

  HomeEntity homeResponse;


  ProductsController(HomeRepository homeRepo) : _presenter = ProductsPresenter(homeRepo){
    _logger = Logger("ProductsController");
  }

  @override
  void initListeners() {
    _presenter.getHomePageOnNext = getHomeOnNext;
    _presenter.getHomePageOnError = getHomeOnError;
    _presenter.getHomePageOnComplete = getHomeOnComplete;
    showLoading();
  }





  search(){
    Navigator.of(getContext()).pushNamed(Pages.search);
  }

  login(){
    Navigator.of(getContext()).pushNamed(Pages.welcome);
  }
  register(){
    Navigator.of(getContext()).pushNamed(Pages.welcome);
  }

  getHomeOnNext(HomeEntity res) {
    this.homeResponse = res;
    _logger.finest("Sliders  ", res);
    refreshUI();
  }

  getHomeOnError(NoSuchMethodError e) {
    dismissLoading();
    _logger.finest(e);
    showGenericSnackbar(getContext(), e.toString());
  }

  getHomeOnComplete() {
    dismissLoading();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }
}