import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/orders/orders_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class OrdersController extends BaseController{
  final OrdersPresenter _presenter;

  List<Order> orders;
  Logger _logger;
  final String status;
  OrdersController(this.status , OrderRepository orderRepository) : _presenter = OrdersPresenter(status, orderRepository){
    _logger = Logger();
    showLoading();
  }

  @override
  void initListeners() {
    initOrdersListener();
  }

  void orderDetails(Order order)async{
    await AppRouter().orderDetails(getContext(), order);
    _presenter.fetchOrders(status);
  }


  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void initOrdersListener() {
    _presenter.getOrdersOnComplete = (){
      dismissLoading();
    };
    _presenter.getOrdersOnError = (e){
      showGenericSnackbar(getContext(), e.message, isError: true);
      Navigator.pop(getContext());
    };
    _presenter.getOrdersOnNext = (orders) {
      this.orders = orders;
      refreshUI();
    };
  }

}