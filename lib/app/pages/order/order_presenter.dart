import 'package:coupon_app/domain/entities/models/OrderCancelResponse.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:coupon_app/domain/usercases/order/cancel_order_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class OrderPresenter extends Presenter{
  final CancelOrderUseCase _cancelOrderUseCase;

  Function cancelOrderOnComplete;
  Function cancelOrderOnError;
  Function cancelOrderOnNext;


  OrderPresenter(OrderRepository orderRepository) : _cancelOrderUseCase = CancelOrderUseCase(orderRepository);


  cancelOrder(String orderId){
    _cancelOrderUseCase.execute(_CancelOrderObserver(this), orderId);
  }

  @override
  void dispose() {
    _cancelOrderUseCase.dispose();
  }

}

class _CancelOrderObserver extends Observer<CancelOrderResponse>{
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