import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/account/address/add/add_address_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/Area.dart';
import 'package:coupon_app/domain/entities/models/Block.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
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

  Area selectedArea;
  Block selectedBlock;

  bool isLoadingAreas = false;
  bool isLoadingBlocks = false;
  bool isDefault = false;

  List<Area> areas;
  List<Block> blocks;

  Logger _logger;

  AddAddressController(
      AddressRepository addressRepository, AuthenticationRepository authRepo)
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

    isLoadingAreas = true;
    refreshUI();
    _presenter.fetchAreas();
  }

  onSelectArea(Area area) {
    isLoadingBlocks = true;
    areaText.text = area.area_name;
    print("============>areaText.text ${areaText.text}");
    selectedArea = area;
    refreshUI();
    _presenter.fetchBlocks(area.id.toString());
    Navigator.of(getContext()).pop();
  }

  onSelectBlock(Block block) {
    blockText.text = block.block_name;
    selectedBlock = block;
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
      showGenericSnackbar(getContext(), e.message, isError: true);
    };

    _presenter.createAddressOnComplete = () {
      dismissLoading();
    };
  }

  initBlocksListeners() {
    _presenter.getBlocksOnNext = (blocks) {
      this.blocks = blocks;
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
    _presenter.getAreasOnNext = (areas) {
      this.areas = areas;
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

  void addAddress() {
    showLoading();
    Address address = Address(
        first_name: firstNameText.text,
        last_name: lastNameText.text,
        area: selectedArea.id.toString(),
        block: selectedBlock.id.toString(),
        floor_flat: flatText.text,
        building: buildingText.text,
        address: addressText.text,
        phone_no: phoneText.text,
        is_default: isDefault);
    print("===============> Address ${address.toJson()}");
    _presenter.createAddress(address);
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
      addAddress();
    }
  }
}
