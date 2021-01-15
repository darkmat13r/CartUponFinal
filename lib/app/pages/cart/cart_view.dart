import 'package:coupon_app/app/components/cart_item.dart';
import 'package:coupon_app/app/components/dotted_view.dart';
import 'package:coupon_app/app/pages/cart/cart_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:easy_localization/easy_localization.dart';
class CartPage extends View {
  @override
  State<StatefulWidget> createState() => CartPageState();

}

class CartPageState extends ViewState<CartPage, CartController> {
  CartPageState() : super(CartController());

  @override
  // TODO: implement view
  Widget get view => Scaffold(
    key: globalKey,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Text(
        LocaleKeys.yourCart.tr(),
        style: heading4.copyWith(color: AppColors.neutralDark),
      ),
      shape: appBarShape,
    ),
    body: _body,
  );

  get _body => ListView(
    shrinkWrap: false,
    children: [
      CartItem(),
      CartItem(),
      CartItem(),

      Padding(
        padding: const EdgeInsets.all(Dimens.spacingMedium),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text(LocaleKeys.items.tr(args: ["2"]), style: bodyTextNormal2.copyWith(color: AppColors.neutralGray),)),
                    Text("\$598.00", style: bodyTextNormal1.copyWith(color: AppColors.neutralDark)),
                  ],
                ),
                SizedBox(
                  height: Dimens.spacingNormal,
                ),
                Row(
                  children: [
                    Expanded(child: Text(LocaleKeys.shipping.tr(), style: bodyTextNormal2.copyWith(color: AppColors.neutralGray),)),
                    Text("\$40.00", style: bodyTextNormal1.copyWith(color: AppColors.neutralDark)),
                  ],
                ),
                SizedBox(
                  height: Dimens.spacingNormal,
                ),
                Row(
                  children: [
                    Expanded(child: Text(LocaleKeys.tax.tr(), style: bodyTextNormal2.copyWith(color: AppColors.neutralGray),)),
                    Text("\$128.00", style: bodyTextNormal1.copyWith(color: AppColors.neutralDark)),
                  ],
                ),
                SizedBox(
                  height: Dimens.spacingNormal,
                ),
                DotWidget(
                  color: AppColors.neutralLight,
                  width: 8,
                  height: Dimens.borderWidth,
                ),
                SizedBox(
                  height: Dimens.spacingNormal,
                ),
                Row(
                  children: [
                    Expanded(child: Text(LocaleKeys.totalPrice.tr(), style: heading6.copyWith(color: AppColors.neutralDark),)),
                    Text("\$766.86", style: heading6.copyWith(color: AppColors.primary)),
                  ],
                ),
                SizedBox(
                  height: Dimens.spacingNormal,
                ),
              ],
            ),
          ),
        ),
      ),

     Padding(
       padding: const EdgeInsets.all(Dimens.spacingMedium ),
       child: RaisedButton(
          onPressed: () {},
          child:  Text(LocaleKeys.checkout.tr(), style: buttonText),
        ),
     ),
    ],
  );

}
