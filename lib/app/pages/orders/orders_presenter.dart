import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:coupon_app/domain/usercases/order/get_orders_use_Case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class OrdersPresenter extends Presenter{
  final GetOrdersUseCase _ordersUseCase;
  Function getOrdersOnComplete;
  Function  getOrdersOnNext;
  Function getOrdersOnError;

  OrdersPresenter(String status, OrderRepository orderRepository) : _ordersUseCase = GetOrdersUseCase(orderRepository){
    fetchOrders(status);
  }

  fetchOrders(String status){
    _ordersUseCase.execute(_GetOrdersObserver(this), status);
  }

  @override
  void dispose() {
    _ordersUseCase.dispose();
  }
}

class _GetOrdersObserver extends Observer<List<Order>> {
  final OrdersPresenter _presenter;


  _GetOrdersObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getOrdersOnComplete != null);
    _presenter.getOrdersOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getOrdersOnError != null);
    _presenter.getOrdersOnError(e);
  }

  @override
  void onNext(List<Order> response) {
    assert(_presenter.getOrdersOnNext != null);
    _presenter.getOrdersOnNext(response);
  }
}