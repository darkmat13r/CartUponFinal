import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/image/zoom_image.dart';
import 'package:coupon_app/app/pages/order/order_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/reviews/create/create_review_view.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:coupon_app/domain/entities/models/OrderDetail.dart';
import 'package:coupon_app/domain/entities/models/OrderDetailResponse.dart';
import 'package:coupon_app/domain/entities/models/Rating.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class OrderController extends BaseController {
  OrderDetail orderDetail;
  Rating rating;

  final OrderPresenter _presenter;

  OrderController(AuthenticationRepository authRepo, OrderRepository orderRepository, {this.orderDetail})
      : _presenter = OrderPresenter(authRepo, orderRepository) {
    if (orderDetail != null) {
      showLoading();
      _presenter.fetchOrderDetails(orderDetail.id.toString());
    }
  }

  @override
  void initListeners() {
    initBaseListeners(_presenter);
    initCancelOrderListeners();
    initOrderDetailsListeners();
  }

  void product() {
    Navigator.of(getContext()).pushNamed(Pages.product);
  }

  void showProductDetails(String productId) {
    AppRouter().productDetailsById(getContext(), productId);
  }

  void cancelOrder() {
    if (orderDetail == null) {
      return;
    }
    showProgressDialog();
    _presenter.cancelOrder(orderDetail.id.toString());
  }

  void addReview() async {
    if(this.orderDetail == null && this.orderDetail.id != null){
      return;
    }
    final result = await Navigator.push(
      getContext(),
      MaterialPageRoute(
          builder: (context) =>
              CreateReviewPage(this.orderDetail.id)),
    );
    if (result != null && result) {
      _presenter.fetchOrderDetails(this.orderDetail.id.toString());
    }
    refreshUI();
  }

  canCancelOrder(){
    if(orderDetail != null ){
      var status =  orderDetail.detail_status.toLowerCase();
      return status  == 'created' || status == 'shipped' || status == 'delivered';
    }
    return false;
  }
  canPostReview(){
    if(rating == null){
      return true;
    }
    if(orderDetail != null ){
      var status =  orderDetail.detail_status.toLowerCase();
      var rated =  rating.rating != null;
      return rated == false && ( status == 'delivered'  ||  status == 'refunded' ||  status == 'cancelled' ||  status == 'used');
    }
    return false;
  }
  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void initCancelOrderListeners() {
    _presenter.cancelOrderOnComplete = () {
      dismissProgressDialog();
      showGenericConfirmDialog(getContext(), LocaleKeys.order.tr(),
          LocaleKeys.msgOrderCancelSuccess.tr(), onConfirm: () {
        Navigator.pop(getContext(), true);
      }, showCancel: false);
    };
    _presenter.cancelOrderOnError = (e) {
      dismissProgressDialog();
      showGenericSnackbar(getContext(), e.message, isError: true);
    };

    _presenter.cancelOrderOnNext = (response) {};
  }

  void initOrderDetailsListeners() {
    _presenter.getOrderDetailsOnComplete = () {
      dismissLoading();
    };

    _presenter.getOrderDetailsOnNext = (OrderDetailResponse response) {
      if(response != null){
        if(response.orderDetail != null){
          this.orderDetail =response.orderDetail;
        }
        this.rating = response.rating;
      }
    };
    _presenter.getOrderDetailsOnError = (error) {
      dismissLoading();
      showGenericSnackbar(getContext(), error.message, isError: true);
    };
  }

  void showImage(String qr_image) {
    Navigator.of(getContext()).push(MaterialPageRoute(
        builder: (context) => ZoomImage(qr_image
        )));
  }
}
