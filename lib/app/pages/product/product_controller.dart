import 'dart:async';
import 'dart:math';

import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/image/zoom_image.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/product/product_presenter.dart';
import 'package:coupon_app/app/pages/reviews/create/create_review_view.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductVariant.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';
import 'package:coupon_app/domain/entities/models/ProductWithRelated.dart';
import 'package:coupon_app/domain/entities/models/Rating.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:coupon_app/domain/repositories/whishlist_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';

class ProductController extends BaseController {
  List<ProductDetail> similarProducts = [];
  List<Rating> ratings = [];
  bool isAddedToWhishlist = false;
  String productId;
  String productSlug;
  bool showTimer = false;
  bool isMarkerLoaded = false;
  bool isVariantRequired = false;
  Completer<GoogleMapController> mapController = Completer();
  ProductPresenter _presenter;

  ProductVariantValue selectedProductVariant;

  ProductDetail product;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  CameraPosition cameraPosition;
  ProductController(
      AuthenticationRepository authRepo,
      ProductRepository productRepository,
      WhishlistRepository whishlistRepository, {this.productId, this.productSlug})
      : _presenter = ProductPresenter(
            authRepo, productRepository, whishlistRepository,
            productId: productId, productSlug: productSlug){

  }

  String elapsedTime;

  @override
  void initListeners() {
    initBaseListeners(_presenter);
    showLoading();
    _initGetProductDetailsListeners();
    // _initSimilarProductListeners();
    _initAddToWhishlistListeners();
  }

  addItemToWhishlist(Product product) async {
    var currentUser = await SessionHelper().getCurrentUser();
    if (currentUser == null) {
      Navigator.of(getContext()).pushNamed(Pages.login);
    } else {
      if (product != null) {
        isAddedToWhishlist = true;
        refreshUI();
        showGenericSnackbar(getContext(), LocaleKeys.itemAddedToWhishlist.tr());
        _presenter.addToWhishlist(product);
      }
    }
  }

  _initAddToWhishlistListeners() {
    _presenter.addToWhichlistOnNext = (whishlist) {};
    _presenter.addToWhishlistOnError = (e) {
      showGenericSnackbar(getContext(), e.message, isError: true);
    };
    _presenter.addToWhishlistOnComplete = () {};
  }

  _initSimilarProductListeners() {
    _presenter.getSimilarProductOnNext = (similarProducts) {
      this.similarProducts = similarProducts;
      refreshUI();
    };
    _presenter.getSimilarProductOnComplete = () {
      dismissLoading();
    };
    _presenter.getSimilarProductOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getContext(), e.message, isError: true);
    };
  }

  _checkValidTimer() {
    if (product.product.offer_from != null &&
        product.product.offer_to != null) {
      isValidTime(DateHelper.isValidTime(
          DateHelper.parseServerDateTime(product.product.offer_from),
          DateHelper.parseServerDateTime(product.product.offer_to)));
    }
  }

  _initGetProductDetailsListeners() {
    _presenter.getProductOnNext = (ProductWithRelated details) {
      this.product = details.productDetail;
      this.similarProducts = details.relatedProducts;
      this.ratings = details.ratings;
      loadMarkers();
      getSellerPosition();
      _checkValidTimer();
      refreshUI();
    };
    _presenter.getProductOnComplete = () {
      dismissLoading();
    };
    _presenter.getProductOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getContext(), e.message, isError: true);
      Navigator.pop(getContext());
      Logger().e(e.stackTrace);
    };
  }

  void search(String categoryId) {
    AppRouter().categorySearchById(getContext(), categoryId);
  }

  onSelectVariant(ProductVariantValue variantValue) {
    this.selectedProductVariant = variantValue;
    refreshUI();
  }

  void shareProduct() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    final RenderBox box = getContext().findRenderObject() as RenderBox;
    Share.share(
        LocaleKeys.fmtShareProduct.tr(
            args: ["https://cartupon.com/product/detail/${this.product.slug}"]),
        subject: "CartUpon",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void reviews() {
    Navigator.of(getContext()).pushNamed(Pages.reviews);
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }

  void openImage(String image) {
    Navigator.of(getContext())
        .push(MaterialPageRoute(builder: (context) => ZoomImage(image)));
  }

  void isValidTime(isValid) {
    showTimer = isValid;
    refreshUI();
  }

  void addToCartWithVariant(
      Product product, ProductVariantValue selectedProductVariant) async{
    if (product.isVariantRequired() && selectedProductVariant == null) {
      Logger().e("Varaint is required");
      showGenericSnackbar(
          getContext(),
          LocaleKeys.errorSelectVariant
              .tr(args: [product.getRequiredVariant().name.toLowerCase()]),
          isError: true);
      return;
    }

    try{
     await CartStream().addToCart(product, selectedProductVariant);
    }catch(e){
      showGenericDialog(
          getContext(),
          LocaleKeys.error.tr(),
          e.message);
    }
  }

  getSellerPosition() {
    if (canShowLocation()){
      cameraPosition =  CameraPosition(
        target: LatLng(double.tryParse(product.product.seller.latitude), double.tryParse(product.product.seller.longitude)),
        zoom: 20,
      );
    }
    refreshUI();
  }
  int _markerIdCounter = 1;
  canShowLocation(){
    return product != null &&
        product.product != null &&
        product.product.seller != null &&
        product.product.seller.latitude != null &&
        product.product.seller.longitude != null;
  }
  void loadMarkers() {
    markers.clear();
    if (canShowLocation()){
       MarkerId markerId = MarkerId(product.product.seller.id.toString());
        Marker marker = Marker(
         markerId: markerId,
         position: LatLng(
           double.tryParse(product.product.seller.latitude),
           double.tryParse(product.product.seller.longitude),
         ),
         infoWindow: InfoWindow(title: product.product.seller.seller_name, snippet: product.product.seller.address),
       );
      markers[markerId] = marker;
    }
    refreshUI();
  }
}
