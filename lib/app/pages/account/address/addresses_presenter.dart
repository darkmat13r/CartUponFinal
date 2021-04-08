import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:coupon_app/domain/usercases/address/delete_address_use_case.dart';
import 'package:coupon_app/domain/usercases/address/get_addresses_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddressesPresenter extends Presenter {
  GetAddressesUseCase _addressesUseCase;
  DeleteAddressUseCase _deleteAddressUseCase;

  Function getAddressesOnComplete;
  Function getAddressesOnNext;
  Function getAddressesOnError;

  Function deleteAddressOnComplete;
  Function deleteAddressOnNext;
  Function deleteAddressOnError;


  AddressesPresenter(AddressRepository addressRepo)
      : _addressesUseCase = GetAddressesUseCase(addressRepo),
        _deleteAddressUseCase = DeleteAddressUseCase(addressRepo){
    fetchAddresses();
  }


  fetchAddresses(){
    _addressesUseCase.execute(_GetAddressesObserver(this));
  }


  delete(Address address){
    _deleteAddressUseCase.execute(_DeleteAddressObserver(this),address.id.toString());
  }

  @override
  void dispose() {
    _addressesUseCase.dispose();
  }
}

class _DeleteAddressObserver extends Observer<void>{
  AddressesPresenter _presenter;

  _DeleteAddressObserver(this._presenter);
  @override
  void onComplete() {
    assert(_presenter.deleteAddressOnComplete != null);
    _presenter.deleteAddressOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.deleteAddressOnError != null);
    _presenter.deleteAddressOnError(e);
  }

  @override
  void onNext(void response) {
    assert(_presenter.deleteAddressOnNext != null);
    _presenter.deleteAddressOnNext(response);
  }

}

class _GetAddressesObserver extends Observer<List<Address>> {
  AddressesPresenter _presenter;

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
