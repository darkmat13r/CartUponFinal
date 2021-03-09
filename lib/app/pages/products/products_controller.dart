import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/product/product_presenter.dart';
import 'package:coupon_app/app/pages/products/products_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/dummy.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:coupon_app/domain/repositories/banners/slider_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
import 'package:coupon_app/domain/entities/slider_banner_entity.dart';
class ProductsController extends BaseController{
  List<ProductEntity> products = DummyProducts.products();

  ProductsPresenter _presenter;

  Logger _logger;

  List<SliderBannerEntity> sliders = [];


  ProductsController(SliderRepository sliderRepository) : _presenter = ProductsPresenter(sliderRepository){
  _logger = Logger("ProductsController");
  }

  @override
  void initListeners() {
    _presenter.getSlidersOnNext = getSlidersOnNext;
    _presenter.getSlidersOnError = getSlidersOnError;
    _presenter.getSlidersOnComplete = getSlidersOnComplete;
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

  getSlidersOnNext(List<SliderBannerEntity> sliders) {
    this.sliders = sliders;
    _logger.finest("Sliders  ", sliders);
    refreshUI();
  }

  getSlidersOnError(NoSuchMethodError e) {
    dismissLoading();
    _logger.finest(e);
    print("Error ${e.stackTrace}");
    showGenericSnackbar(getContext(), e.toString());
  }

  getSlidersOnComplete() {
    dismissLoading();
  }

  @override
  void onDisposed(BuildContext context) {
    _presenter.dispose();
    super.onDisposed(context);
  }
}