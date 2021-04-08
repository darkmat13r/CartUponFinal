import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/account/address/addresses_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class AddressesController extends BaseController{

  AddressesPresenter _presenter;

  List<Address> addresses;

  Logger  _logger;

  AddressesController(AddressRepository addressRepository) : _presenter = AddressesPresenter(addressRepository){
    _logger = Logger("AddressesController");
  }

  @override
  void initListeners() {
    _presenter.getAddressesOnNext = (res){
      this.addresses = res;
      refreshUI();
    };
    _presenter.getAddressesOnComplete = (){
      dismissLoading();
    };

    _presenter.getAddressesOnError = (e){
      dismissLoading();
      showGenericSnackbar(getContext(), e.message);
    };
  }

  void addAddress() {
    Navigator.of(getContext()).pushNamed(Pages.addAddress);
  }


  delete(Address address){

  }
}