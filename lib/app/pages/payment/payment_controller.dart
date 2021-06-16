import 'dart:convert';

import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/payment/payment_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/user_entity.dart';

class PaymentController extends Controller{
  PaymentPresenter _presenter;
  var progressHUD;
  bool isLoading = false;
  PaymentController(authRepo) : _presenter = PaymentPresenter(authRepo);

  @override
  void initListeners() {

  }

  void dismissLoading() {
    isLoading = false;
    //ProgressHUD.of(getContext()).dismiss();
  }

  void processResponse(String message) async{
    Map<String, dynamic> response =  jsonDecode(message);
    if(response['status'] == "COMPLETED" || response['status'] == "APPROVED"){
       showGenericConfirmDialog(getContext(),LocaleKeys.order.tr(), LocaleKeys.msgOrderSuccess, onConfirm : (){
        Navigator.of(getContext()).pushReplacementNamed(Pages.main);
      }, onCancel: (){
         Navigator.of(getContext()).pushReplacementNamed(Pages.main);
       });
    }else{
      showGenericSnackbar(getContext(), LocaleKeys.msgOrderPaymentFailed.tr(args: [response['id']]), isError: false);
      Navigator.of(getContext()).pop();
    }
   // ;
  }

}