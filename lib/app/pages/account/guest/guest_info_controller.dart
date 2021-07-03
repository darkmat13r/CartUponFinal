import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/account/address/add/add_address_presenter.dart';
import 'package:coupon_app/app/pages/account/guest/guest_info_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/Area.dart';
import 'package:coupon_app/domain/entities/models/Block.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class GuestInfoController extends BaseController {
  GuestInfoPresenter _presenter;

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

  String mobileNumber;
  String countryCode;
  int payMode;
  bool useWallet;
  bool onlyCoupon;
var success =false;
  GuestInfoController(AddressRepository addressRepository,
      OrderRepository orderRepository, AuthenticationRepository authRepo,
      {this.mobileNumber,
      this.countryCode,
      this.payMode,
      this.useWallet,
      this.onlyCoupon})
      : _presenter =
            GuestInfoPresenter(addressRepository, authRepo, orderRepository) {
    _logger = Logger();
    firstNameText = TextEditingController();
    lastNameText = TextEditingController();
    flatText = TextEditingController();
    phoneText = TextEditingController();
    buildingText = TextEditingController();
    addressText = TextEditingController();
    areaText = TextEditingController();
    blockText = TextEditingController();
    emailText = TextEditingController();
    isLoadingAreas = true;
    phoneText.text = "${countryCode}-${mobileNumber}";
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
    initPlaceOrderListeners();
  }

  void initPlaceOrderListeners() {
    _presenter.placeOrderOnComplete = () {
      dismissLoading();
      if (payMode == 1 || payMode == 3) {
        success = true;
        showGenericConfirmDialog(getContext(), LocaleKeys.order.tr(),
            LocaleKeys.msgOrderSuccess.tr(),
            showCancel: false,
            onConfirm: () {
          onCashOnDeliverOrderSuccess();
        }, onCancel: () {
          onCashOnDeliverOrderSuccess();
        });
      }
    };
    _presenter.placeOrderOnNext = (PlaceOrderResponse response) {
      _logger.e(response.paymentURL);
      dismissLoading();
      if (response.paymentURL != null) {
       startPaymentPage(response.paymentURL);
      }
    };
    _presenter.placeOrderOnError = (e) {
      showGenericSnackbar(getContext(), e.message, isError: true);
      dismissLoading();
      dismissProgressDialog();
    };
  }
  void startPaymentPage(String paymentUrl) async{
    var result = await AppRouter().payment(getContext(), paymentUrl);
    if(result ?? false){
      success = true;
      Navigator.of(getContext()).pushReplacementNamed(Pages.main);
    }
  }
  onCashOnDeliverOrderSuccess() {
    Navigator.of(getContext()).pushReplacementNamed(Pages.main);
    CartStream().clear();
  }
  Future<bool> onWillPop() {
    if(success){
      Navigator.of(getContext()).pushReplacementNamed(Pages.main);
    }
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

  getAddress() {
    showLoading();
    return Address(
        first_name: firstNameText.text,
        last_name: lastNameText.text,
        area: selectedArea,
        block: selectedBlock,
        floor_flat: flatText.text,
        building: buildingText.text,
        address: addressText.text,
        email: emailText.text,
        countryCode: countryCode,
        phone_no: mobileNumber,
        is_default: isDefault);
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
      checkout();
    }
  }

  void checkout() {
    var address = getAddress();
    var addressId = address != null ? address.id : 1;
    _presenter.placeOrder(
        addressId, addressId, payMode == 1 && payMode != 3 ? "cash" : "online",
        isGuest: currentUser == null, address: address, useWallet: useWallet);
  }
}
