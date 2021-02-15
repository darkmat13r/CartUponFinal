import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

AppBar customAppBar({Widget title}){
  return AppBar(
    title: title,
    actions: [
      IconButton(
        icon: Icon(MaterialIcons.search), onPressed: () {  },
      ),
      IconButton(
        icon: Icon(MaterialIcons.shopping_cart), onPressed: () {  },
      )
    ],
  );
}