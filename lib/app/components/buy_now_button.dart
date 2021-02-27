import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BuyNowButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BuyNowButtonState();
}

class BuyNowButtonState extends State<BuyNowButton> {
  final cartStream = CartStream();
  @override
  Widget build(BuildContext context) => ButtonTheme(
    height: 28,
    minWidth: 50,
    buttonColor: AppColors.accent,
    shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.all(Radius.circular(Dimens.buttonCornerRadius))),
    child: RaisedButton.icon(
      elevation: 0,
      onPressed: () {
        cartStream.addToCart();
        showDialog(
            context: context,
            builder: (ctx) => new AlertDialog(
              title: new Text(LocaleKeys.message.tr()),
              content: new Text(LocaleKeys.productAddedToCard.tr()),
              actions: [
                TextButton(onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).pushNamed(Pages.checkout);
                },
                  child: Text(LocaleKeys.payNow.tr(), style: buttonText.copyWith(color: AppColors.accent),),

                ),
                TextButton(onPressed: () {
                  Navigator.pop(ctx);
                },
                  child: Text(LocaleKeys.continueShopping.tr(), style: buttonText.copyWith(color: AppColors.accent),),

                )
              ],
            ));
      },
      icon: Icon(MaterialCommunityIcons.cart_plus, color: AppColors.neutralLight, size: 16,),
     label:  Text(LocaleKeys.buyNow.tr(), style: buttonText.copyWith(fontSize: 12),),
    ),
  );
}
