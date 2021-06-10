import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/pages/cart/cart_view.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartWithToolbarPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CartWithToolbarPageState();

}

class _CartWithToolbarPageState extends State<CartWithToolbarPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: Text(LocaleKeys.yourCart.tr(), style: heading5.copyWith(color: AppColors.primary),)),
      body: CartPage(),
    );
  }

}