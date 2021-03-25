import 'dart:async';

import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CartButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {

  final cartStream = CartStream();
  var _cartItemCount = 0;
  StreamSubscription<int> streamSubscription;
  GlobalKey _globalKey = new GlobalKey();

  _CartButtonState() {
    _cartItemCount = cartStream.getCurrentItemCount();
   streamSubscription = cartStream.onAddToCart().listen((event) {
      setState(() {
        _cartItemCount = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key:_globalKey,
      children: [
        Center(
          child: IconButton(
            icon: Icon(MaterialCommunityIcons.cart),
            onPressed: () {
              Navigator.of(context).pushNamed(Pages.cart);
            },
          ),
        ),
        (_cartItemCount ?? 0) > 0 ? Positioned(
          top: 10,
          right: 10,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.error
            ),
            child: Center(child: Text("${_cartItemCount}",
              style: captionNormal1.copyWith(
                  color: AppColors.neutralLight, fontSize: 8),)),
          ),
        ) : SizedBox(),
      ],
    );
  }
  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
  }
}
