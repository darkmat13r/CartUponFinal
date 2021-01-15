
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AccountController extends Controller{
  @override
  void initListeners() {
  }

  void goToPage(page) {
    Navigator.of(getContext()).pushNamed(page);
  }

}