import 'dart:async';

import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/account/address/add/add_address_presenter.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/Area.dart';
import 'package:coupon_app/domain/entities/models/Block.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

class AddAddressController extends BaseController {
  AddAddressPresenter _presenter;

  TextEditingController firstNameText;
  TextEditingController lastNameText;
  TextEditingController areaText;
  TextEditingController blockText;
  TextEditingController flatText;
  TextEditingController buildingText;
  TextEditingController addressText;
  TextEditingController phoneText;
  TextEditingController emailText;

  Area selectedArea;
  Block selectedBlock;

  bool isLoadingAreas = false;
  bool isLoadingBlocks = false;
  bool isDefault = false;

  bool askPersonalDetails = false;
  bool guest = false;

  List<Area> areas;
  List<Block> blocks;

  Logger _logger;

  Address address;

  Country selectedCountry;
  List<Country> countries;

  AddAddressController(this.address, AddressRepository addressRepository,
      AuthenticationRepository authRepo,
      {this.askPersonalDetails, this.guest})
      : _presenter = AddAddressPresenter(addressRepository, authRepo) {
    _logger = Logger("AddAddressController");
    firstNameText = TextEditingController();
    lastNameText = TextEditingController();
    flatText = TextEditingController();
    buildingText = TextEditingController();
    addressText = TextEditingController();
    phoneText = TextEditingController();
    areaText = TextEditingController();
    blockText = TextEditingController();
    emailText = TextEditingController();
    getCachedCountry();
    getCachedCountries();
    isLoadingAreas = true;
    refreshUI();
    _presenter.fetchAreas();
    Timer.periodic(Duration(microseconds: 400), (Timer timer){
      fillValues();
    });
  }

  void getCachedCountry() async {
    selectedCountry = Config().selectedCountry;
    refreshUI();
  }

  void getCachedCountries() async {
    countries = await SessionHelper().cachedCounties();
    if (address != null) {
      try {
        //  selectedCountry = countries.firstWhere((element) => element.dial_code == address.)
      } catch (e) {}
    }
    refreshUI();
  }

  fillValues() {
    if (this.address != null) {
      firstNameText.text = this.address.first_name;
      lastNameText.text = this.address.last_name;
      flatText.text = this.address.floor_flat;
      buildingText.text = this.address.building;
      addressText.text = this.address.address;
      phoneText.text = this.address.phone_no;

      if (this.address.area != null) {
        if (isLocaleEnglish()) {
          areaText.text = this.address.area.area_name;
        } else {
          areaText.text = this.address.area.area_name_ar;
        }
        selectedArea = this.address.area;
      }
      if (this.address.block != null) {
        blockText.text = isLocaleEnglish()
            ? this.address.block.block_name
            : this.address.block.block_name_ar;
        selectedBlock = this.address.block;
      }
      isDefault = this.address.is_default;
    }
  }

  onSelectArea(Area area) {
    isLoadingBlocks = true;

    if (isLocaleEnglish()) {
      areaText.text = area.area_name;
    } else {
      areaText.text = area.area_name_ar;
    }
    selectedArea = area;
    selectedBlock = null;
    blockText.text = "";
    if (blocks != null) blocks.clear();
    refreshUI();
    _presenter.fetchBlocks(area.id.toString());
    Navigator.of(getContext()).pop();
  }

  onSelectBlock(Block block) {
    blockText.text = isLocaleEnglish() ? block.block_name : block.block_name_ar;
    selectedBlock = block;
    dismissProgressDialog();
    refreshUI();
    Navigator.of(getContext()).pop();
  }

  @override
  void initListeners() {
    initBaseListeners(_presenter);
    initAreasListeners();
    initBlocksListeners();
    initCreateAddressListeners();
  }

  initCreateAddressListeners() {
    _presenter.createAddressOnNext = (res) {
      dismissLoading();
      Navigator.of(getContext()).pop();
    };
    _presenter.createAddressOnError = (e) {
      dismissLoading();
      print("Create AdressOnError  ================= ${e}");
      showGenericSnackbar(getContext(), e.message, isError: true);
    };

    _presenter.createAddressOnComplete = () {
      dismissLoading();
    };
  }

  initBlocksListeners() {
    _presenter.getBlocksOnNext = (List<Block> blocks) {
      this.blocks = blocks;
      this.blocks.sort((a, b) => isLocaleEnglish()
          ? a.block_name.toLowerCase().compareTo(a.block_name.toLowerCase())
          : a.block_name_ar.toLowerCase().compareTo(a.block_name_ar.toLowerCase()));
      isLoadingBlocks = false;
      refreshUI();
    };

    _presenter.getBlocksOnError = (e) {
      isLoadingBlocks = false;
      refreshUI();

      showGenericSnackbar(getContext(), e.message, isError: true);
    };

    _presenter.getBlocksOnComplete = () {
      isLoadingBlocks = false;
      refreshUI();
    };
  }

  initAreasListeners() {
    _presenter.getAreasOnNext = (List<Area> areas) {
      this.areas = areas;
      this.areas.sort((a, b) => isLocaleEnglish()
          ? a.area_name.toLowerCase().compareTo(a.area_name.toLowerCase())
          : a.area_name_ar.toLowerCase().compareTo(a.area_name_ar.toLowerCase()));
      isLoadingAreas = false;
      refreshUI();
    };
    _presenter.getAreasOnError = (e) {
      isLoadingAreas = false;
      refreshUI();
      showGenericSnackbar(getContext(), e.message, isError: true);
    };
    _presenter.getAreasOnComplete = () {
      isLoadingAreas = false;
      refreshUI();
    };
  }

  void editAddress() {
    showLoading();
    Address data = Address(
        id: address != null ? address.id : null,
        first_name: firstNameText.text,
        last_name: lastNameText.text,
        area: selectedArea,
        block: selectedBlock,
        floor_flat: flatText.text,
        building: buildingText.text,
        address: addressText.text,
        phone_no: phoneText.text,
        is_default: isDefault);

    _presenter.updateAddress(data);
  }

  void addAddress() {
    showLoading();
    Address data = Address(
        first_name: firstNameText.text,
        last_name: lastNameText.text,
        area: selectedArea,
        block: selectedBlock,
        floor_flat: flatText.text,
        building: buildingText.text,
        address: addressText.text,
        email: emailText.text,
        countryCode: selectedCountry.dial_code,
        phone_no: phoneText.text,
        is_default: isDefault);
    if (guest) {
      Navigator.of(getContext()).pop(data);
    } else {
      _presenter.createAddress(data);
    }
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void checkForm(Map<String, Object> params) {
    dynamic formKey = params['formKey'];
    // Validate params
    assert(formKey is GlobalKey<FormState>);
    if (formKey.currentState.validate()) {
      if (address == null) {
        addAddress();
      } else {
        editAddress();
      }
    }
  }

  void setSelectedCountry(Country countri) {
    selectedCountry = countri;
    refreshUI();
  }
}
