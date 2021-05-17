import 'package:coupon_app/app/components/cart_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

AppBar customAppBar({Widget title, TabBar tabs}){
  return AppBar(
    title: title,
    bottom: tabs,
    actions: [
      IconButton(
        icon: Icon(MaterialIcons.search), onPressed: () {  },
      ),
      CartButton()
    ],
  );
}