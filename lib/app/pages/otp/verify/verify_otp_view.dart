import 'package:coupon_app/app/pages/otp/verify/verify_otp_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class VerifyOtpPage extends View{
  @override
  State<StatefulWidget> createState() => _VerifyOtpPageState();

}

class _VerifyOtpPageState extends ViewState<VerifyOtpPage, VerifyOtpController>{
  _VerifyOtpPageState() : super(VerifyOtpController());

  @override
  Widget get view => Scaffold(
    key: globalKey,
    appBar: AppBar(elevation: 0,),
    body: Text("Verify otp page"),
  );
  final Widget _logo = SizedBox(
      height: 90,
      child: Image.asset(
        Resources.logo,
      ));

}