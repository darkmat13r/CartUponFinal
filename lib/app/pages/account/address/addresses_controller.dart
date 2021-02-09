import 'package:coupon_app/app/pages/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddressesController extends Controller{
  @override
  void initListeners() {
    // TODO: implement initListeners
  }

  void addAddress() {
    Navigator.of(getContext()).pushNamed(Pages.addAddress);
  }

}