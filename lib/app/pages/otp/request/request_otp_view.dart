import 'package:coupon_app/app/pages/otp/request/request_otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class RequestOtpPage extends View{
  @override
  State<StatefulWidget> createState()  => _RequestOtpPageState();

}

class _RequestOtpPageState extends ViewState<RequestOtpPage, RequestOtpController>{
  _RequestOtpPageState() : super(RequestOtpController());

  @override
  Widget get view => Scaffold(
    key: globalKey,
    appBar: AppBar(elevation: 0,),
    body: Text("request otp"),
  );

}