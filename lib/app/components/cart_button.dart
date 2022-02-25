import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
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

class _CartButtonState extends State<CartButton> with SingleTickerProviderStateMixin {

  final cartStream = CartStream();
  var _cartItemCount = 0;
  var _enabled = false;
  StreamSubscription<int> streamSubscription;
  GlobalKey _globalKey = new GlobalKey();
  AnimationController controller;
  _CartButtonState() {
    _cartItemCount = cartStream.getCurrentItemCount();
   if(mounted){
     controller = AnimationController(
       vsync: this,
       duration: Duration(milliseconds: 400),
       reverseDuration: Duration(milliseconds: 400),
     );
   }
   streamSubscription = cartStream.onAddToCart().listen((event) {
      setState(() {

        _cartItemCount = event;
        _enabled =  true;
        Timer(Duration(milliseconds: 500), () {
          if(mounted){
            setState(() {
              _enabled =  false;
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShakeAnimatedWidget(
      enabled: this._enabled,
      duration: Duration(milliseconds: 500),
      shakeAngle: Rotation.deg(z: 20),
      curve: Curves.linear,
      child: Stack(
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
    ),

    );
  }
  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
  }
}
