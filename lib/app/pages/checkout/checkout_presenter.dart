import 'package:coupon_app/app/pages/account/address/addresses_presenter.dart';
import 'package:coupon_app/domain/entities/Cart.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:coupon_app/domain/repositories/cart/cart_repository.dart';
import 'package:coupon_app/domain/usercases/address/get_addresses_use_case.dart';
import 'package:coupon_app/domain/usercases/cart/get_cart_items_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CheckoutPresenter extends Presenter{
  GetCartItemsUseCase _cartItemsUseCase;
  GetAddressesUseCase _addressesUseCase;
  Function getCartOnNext;
  Function getCartOnError;
  Function getCartOnComplete;

  Function getAddressesOnComplete;
  Function getAddressesOnNext;
  Function getAddressesOnError;

  CheckoutPresenter(AddressRepository addressRepo,CartRepository repository) : _cartItemsUseCase = GetCartItemsUseCase(repository),_addressesUseCase = GetAddressesUseCase(addressRepo){
    fetchCart();
    fetchAddresses();
  }

  fetchAddresses(){
    _addressesUseCase.execute(_GetAddressesObserver(this));
  }
  fetchCart(){
    _cartItemsUseCase.execute(_GetCartObserver(this));
  }

  @override
  void dispose() {
    _cartItemsUseCase.dispose();
  }

}
class _GetAddressesObserver extends Observer<List<Address>> {
  CheckoutPresenter _presenter;
  _GetAddressesObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getAddressesOnComplete != null);
    _presenter.getAddressesOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getAddressesOnError != null);
    _presenter.getAddressesOnError(e);
  }

  @override
  void onNext(List<Address> response) {
    assert(_presenter.getAddressesOnNext != null);
    _presenter.getAddressesOnNext(response);
  }
}

class _GetCartObserver extends Observer<Cart> {
  CheckoutPresenter _presenter;


  _GetCartObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getCartOnComplete != null);
    _presenter.getCartOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getCartOnError != null);
    _presenter.getCartOnError(e);
  }

  @override
  void onNext(Cart response) {
    assert(_presenter.getCartOnNext != null);
    _presenter.getCartOnNext(response);
  }
}