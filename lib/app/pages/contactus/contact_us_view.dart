import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget{
  get _body => ListView(
    children: [
      
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: Text(LocaleKeys.contactUs.tr(), style: heading5.copyWith(color: AppColors.primary),)),
      body: _body,
    );
  }

}