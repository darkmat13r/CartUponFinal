import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/Area.dart';
import 'package:coupon_app/domain/entities/models/Block.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/usercases/address/create_address_use_case.dart';
import 'package:coupon_app/domain/usercases/address/get_areas_use_case.dart';
import 'package:coupon_app/domain/usercases/address/get_blocks_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

class AddAddressPresenter extends AuthPresenter {
  GetAreasUseCase _getAreasUseCase;
  Function getAreasOnComplete;
  Function getAreasOnError;
  Function getAreasOnNext;

  GetBlocksUseCase _getBlocksUseCase;
  Function getBlocksOnComplete;
  Function getBlocksOnError;
  Function getBlocksOnNext;

  CreateAddressUseCase _createAddressUseCase;
  Function createAddressOnComplete;
  Function createAddressOnError;
  Function createAddressOnNext;

  Logger _logger;

  AddAddressPresenter(AddressRepository addressRepository, AuthenticationRepository authRepo)
      : _getAreasUseCase = GetAreasUseCase(addressRepository),
        _getBlocksUseCase = GetBlocksUseCase(addressRepository),
        _createAddressUseCase = CreateAddressUseCase(addressRepository), super(authRepo) {
    _logger = Logger("AddAddressPresenter");
  }

  createAddress(Address address){
    _createAddressUseCase.execute(_CreateAddressObserver(this), address);
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
    _createAddressUseCase.dispose();
  }
}

class _GetAreasObserver extends Observer<List<Area>> {
  AddAddressPresenter _presenter;

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
  AddAddressPresenter _presenter;

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

class _CreateAddressObserver extends Observer<Address> {
  AddAddressPresenter _presenter;

  _CreateAddressObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.createAddressOnComplete != null);
    _presenter.createAddressOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.createAddressOnError != null);
    _presenter.createAddressOnError(e);
  }

  @override
  void onNext(Address response) {
    assert(_presenter.createAddressOnNext != null);
    _presenter.createAddressOnNext(response);
  }
}
