import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/order/order_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class OrderController extends BaseController{
  Order order;

  final OrderPresenter _presenter;

  OrderController(OrderRepository orderRepository, {this.order}) : _presenter = OrderPresenter(orderRepository);

  @override
  void initListeners() {
    initCancelOrderListeners();
  }

  void product(){
    Navigator.of(getContext()).pushNamed(Pages.product);
  }
  void showProductDetails(String productId){
    AppRouter().productDetailsById(getContext(), productId);
  }

  void cancelOrder() {
    if(order == null){
      return;
    }
    showProgressDialog();
    _presenter.cancelOrder(order.id.toString());
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void initCancelOrderListeners() {
    _presenter.cancelOrderOnComplete = (){
      dismissProgressDialog();
      showGenericConfirmDialog(getContext(), LocaleKeys.order.tr(), LocaleKeys.msgOrderCancelSuccess.tr(), onConfirm: (){
        Navigator.pop(getContext(), true);
      }, showCancel: false);
    };
    _presenter.cancelOrderOnError = (e){
      dismissProgressDialog();
      showGenericSnackbar(getContext(), e.message, isError: true);
    };

    _presenter.cancelOrderOnNext = (response){

    };

  }
}