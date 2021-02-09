import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddAddressController extends Controller{
  @override
  void initListeners() {
  }

  void addAddress() {
    Navigator.of(getContext()).pop();
  }

}