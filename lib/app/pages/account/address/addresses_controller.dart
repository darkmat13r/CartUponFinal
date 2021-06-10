import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/account/address/addresses_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

class AddressesController extends BaseController {
  AddressesPresenter _presenter;

  List<Address> addresses;

  Logger _logger;
  bool selectionMode = false;

  AddressesController(AddressRepository addressRepository, {selectionMode})
      : _presenter = AddressesPresenter(addressRepository) {
    _logger = Logger("AddressesController");
  }

  @override
  void initListeners() {
    _presenter.getAddressesOnNext = (res) {
      this.addresses = res;
      refreshUI();
    };
    _presenter.getAddressesOnComplete = () {
      dismissLoading();
    };

    _presenter.getAddressesOnError = (e) {
      dismissLoading();

      showGenericSnackbar(getContext(), e.message);
    };

    _presenter.deleteAddressOnNext = (res) {};
    _presenter.deleteAddressOnError = (e) {
      showGenericSnackbar(getContext(), e.message, isError: true);
    };
    _presenter.deleteAddressOnComplete = () {
      _presenter.fetchAddresses();
    };
  }

  void addAddress() async {
    await Navigator.of(getContext()).pushNamed(Pages.addAddress);
    _presenter.fetchAddresses();
  }

  edit(Address address)async{
    await  AppRouter().editAddress(getContext(), address);
    _presenter.fetchAddresses();
  }

  delete(Address address) {
    showGenericConfirmDialog(
        getContext(), LocaleKeys.warning.tr(), LocaleKeys.confirmDelete.tr(),
        onConfirm: () {
          addresses.remove(address);
      Navigator.of(getContext()).pop();
      showLoadingDialog(getContext());

      _presenter.delete(address);
    });
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void select(Address address) {
    Navigator.of(getContext()).pop(address);
  }
}
