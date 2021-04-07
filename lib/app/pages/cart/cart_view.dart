import 'package:coupon_app/app/components/cart_item.dart';
import 'package:coupon_app/app/components/dotted_view.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/cart/cart_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:coupon_app/data/repositories/cart/data_cart_repository.dart';
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
  CartPageState() : super(CartController(DataCartRepository()));

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: ControlledWidgetBuilder(
          builder: (BuildContext context, CartController controller) {
            return StateView(
                controller.isLoading
                    ? EmptyState.LOADING
                    : _isCartEmpty(controller)
                        ? EmptyState.EMPTY
                        : EmptyState.CONTENT,
                _body, emptyStateIcon: Feather.shopping_cart, emptyStateMessage: LocaleKeys.emptyCartMsg.tr(),);
          },
        ),
      );

  get _body => ListView(
        shrinkWrap: false,
        children: [
         // _cartItems,
          _cartInfo,
          Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: RaisedButton(
              onPressed: () {},
              child: Text(LocaleKeys.checkout.tr(), style: buttonText),
            ),
          ),
        ],
      );

  get _cartInfo => ControlledWidgetBuilder(builder: (BuildContext context, CartController controller){
    return Padding(
      padding: const EdgeInsets.all(Dimens.spacingMedium),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingMedium),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                        LocaleKeys.items.tr(args: ["2"]),
                        style: bodyTextNormal2.copyWith(
                            color: AppColors.neutralGray),
                      )),
                  Text("KD${controller.cart.total ?? 0}",
                      style: bodyTextNormal1.copyWith(
                          color: AppColors.neutralDark)),
                ],
              ),
              SizedBox(
                height: Dimens.spacingNormal,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                        LocaleKeys.shipping.tr(),
                        style: bodyTextNormal2.copyWith(
                            color: AppColors.neutralGray),
                      )),
                  Text("KD0",
                      style: bodyTextNormal1.copyWith(
                          color: AppColors.neutralDark)),
                ],
              ),
              SizedBox(
                height: Dimens.spacingNormal,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                        LocaleKeys.tax.tr(),
                        style: bodyTextNormal2.copyWith(
                            color: AppColors.neutralGray),
                      )),
                  Text("KD0",
                      style: bodyTextNormal1.copyWith(
                          color: AppColors.neutralDark)),
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
                  Expanded(
                      child: Text(
                        LocaleKeys.totalPrice.tr(),
                        style:
                        heading6.copyWith(color: AppColors.neutralDark),
                      )),
                  Text("KD${controller.cart.total ?? 0}",
                      style: heading6.copyWith(color: AppColors.primary)),
                ],
              ),
              SizedBox(
                height: Dimens.spacingNormal,
              ),
            ],
          ),
        ),
      ),
    );
  });

 /* get _cartItems => ControlledWidgetBuilder(
          builder: (BuildContext context, CartController controller) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controller.cart.cartItems.length,
            itemBuilder: (BuildContext context, int index) {
          return CartItemView(controller.cart.cartItems[index]);
        });
      });*/

  _isCartEmpty(CartController controller) {
    return controller.cart == null ||
        controller.cart.cartItems == null ||
        controller.cart.cartItems.length == 0;
  }
}
