
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AccountController extends Controller{


  @override
  void initListeners() {
  }


  @override
  void initController(GlobalKey<State<StatefulWidget>> key) {

  }

  void goToPage(page) {
    Navigator.of(getContext()).pushNamed(page);
  }

}

