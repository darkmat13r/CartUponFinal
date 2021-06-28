import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/domain/entities/models/OrderCancelResponse.dart';
import 'package:coupon_app/domain/entities/models/OrderDetailResponse.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:coupon_app/domain/usercases/order/cancel_order_use_case.dart';
import 'package:coupon_app/domain/usercases/order/get_order_detail_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class OrderPresenter extends AuthPresenter {
  final CancelOrderUseCase _cancelOrderUseCase;
  final GetOrderDetailUseCase _orderDetailUseCase;

  Function cancelOrderOnComplete;
  Function cancelOrderOnError;
  Function cancelOrderOnNext;

  Function getOrderDetailsOnComplete;
  Function getOrderDetailsOnError;
  Function getOrderDetailsOnNext;
  OrderPresenter(AuthenticationRepository authRepo, OrderRepository orderRepository)
      : _cancelOrderUseCase = CancelOrderUseCase(orderRepository),
        _orderDetailUseCase = GetOrderDetailUseCase(orderRepository), super(authRepo);

  cancelOrder(String orderId) {
    _cancelOrderUseCase.execute(_CancelOrderObserver(this), orderId);
  }

  fetchOrderDetails(String orderId){
    _orderDetailUseCase.execute(_GetOrderDetailsObserver(this), orderId);
  }

  @override
  void dispose() {
    _cancelOrderUseCase.dispose();
    _orderDetailUseCase.dispose();
  }
}

class _GetOrderDetailsObserver extends Observer<OrderDetailResponse>{
  final OrderPresenter _presenter;

  _GetOrderDetailsObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getOrderDetailsOnComplete != null);
    _presenter.getOrderDetailsOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getOrderDetailsOnError != null);
    _presenter.getOrderDetailsOnError(e);
  }

  @override
  void onNext(OrderDetailResponse response) {
    assert(_presenter.getOrderDetailsOnNext  != null);
    _presenter.getOrderDetailsOnNext(response);
  }

}

class _CancelOrderObserver extends Observer<CancelOrderResponse> {
  final OrderPresenter _presenter;

  _CancelOrderObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.cancelOrderOnComplete != null);
    _presenter.cancelOrderOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.cancelOrderOnError != null);
    _presenter.cancelOrderOnError(e);
  }

  @override
  void onNext(CancelOrderResponse response) {
    assert(_presenter.cancelOrderOnNext != null);
    _presenter.cancelOrderOnNext(response);
  }
}
