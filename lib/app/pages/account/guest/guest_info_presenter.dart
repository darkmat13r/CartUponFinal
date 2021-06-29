import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/Area.dart';
import 'package:coupon_app/domain/entities/models/Block.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:coupon_app/domain/usercases/address/create_address_use_case.dart';
import 'package:coupon_app/domain/usercases/address/get_areas_use_case.dart';
import 'package:coupon_app/domain/usercases/address/get_blocks_use_case.dart';
import 'package:coupon_app/domain/usercases/address/update_address_use_case.dart';
import 'package:coupon_app/domain/usercases/order/place_order_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

class GuestInfoPresenter extends AuthPresenter {

  PlaceOrderUseCase _placeOrderUseCase;
  Function placeOrderOnComplete;
  Function placeOrderOnNext;
  Function placeOrderOnError;

  GetAreasUseCase _getAreasUseCase;
  Function getAreasOnComplete;
  Function getAreasOnError;
  Function getAreasOnNext;

  GetBlocksUseCase _getBlocksUseCase;
  Function getBlocksOnComplete;
  Function getBlocksOnError;
  Function getBlocksOnNext;



  UpdateAddressUseCase _updateAddressUseCase;

  Logger _logger;

  GuestInfoPresenter(AddressRepository addressRepository, AuthenticationRepository authRepo, OrderRepository orderRepository)
      : _getAreasUseCase = GetAreasUseCase(addressRepository),
        _getBlocksUseCase = GetBlocksUseCase(addressRepository),
        _placeOrderUseCase = PlaceOrderUseCase(orderRepository),
        _updateAddressUseCase = UpdateAddressUseCase(addressRepository), super(authRepo) {
    _logger = Logger("AddAddressPresenter");
  }

  placeOrder(int shippingAddressId, int billingAddressId, String payMode,
      {bool isGuest, Address address, bool useWallet}) {
    _placeOrderUseCase.execute(
        _PlaceOrderObserver(this),
        PlaceOrderParams(
            shippingAddress: shippingAddressId.toString(),
            billingAddress: billingAddressId.toString(),
            payMode: payMode,
            isGuest: isGuest,
            useWallet: useWallet,
            address: address));
  }
  fetchAreas(){
    _getAreasUseCase.execute(_GetAreasObserver(this));
  }

  fetchBlocks(String areaId){
    _getBlocksUseCase.execute(_GetBlockObserver(this), areaId);
  }
  @override
  void dispose() {
    _getBlocksUseCase.dispose();
    _getAreasUseCase.dispose();

  }
}
class _PlaceOrderObserver extends Observer<PlaceOrderResponse> {
  final GuestInfoPresenter _presenter;

  _PlaceOrderObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.placeOrderOnComplete != null);
    _presenter.placeOrderOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.placeOrderOnError != null);
    _presenter.placeOrderOnError(e);
  }

  @override
  void onNext(PlaceOrderResponse response) {
    assert(_presenter.placeOrderOnNext != null);
    _presenter.placeOrderOnNext(response);
  }
}
class _GetAreasObserver extends Observer<List<Area>> {
  GuestInfoPresenter _presenter;

  _GetAreasObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getAreasOnComplete != null);
    _presenter.getAreasOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getAreasOnError != null);
    _presenter.getAreasOnError(e);
  }

  @override
  void onNext(List<Area> response) {
    assert(_presenter.getAreasOnNext != null);
    _presenter.getAreasOnNext(response);
  }
}

class _GetBlockObserver extends Observer<List<Block>> {
  GuestInfoPresenter _presenter;

  _GetBlockObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getBlocksOnComplete != null);
    _presenter.getBlocksOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getBlocksOnError != null);
    _presenter.getBlocksOnError(e);
  }

  @override
  void onNext(List<Block> response) {
    assert(_presenter.getBlocksOnNext != null);
    _presenter.getBlocksOnNext(response);
  }
}

