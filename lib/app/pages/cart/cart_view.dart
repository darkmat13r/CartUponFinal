import 'package:coupon_app/app/components/cart_item.dart';
import 'package:coupon_app/app/components/dotted_view.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/cart/cart_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/data/repositories/cart/data_cart_repository.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
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
  CartPageState() : super(CartController(DataAuthenticationRepository(),DataCartRepository()));

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
              _body,
              emptyStateIcon: Feather.shopping_cart,
              emptyStateMessage: LocaleKeys.emptyCartMsg.tr(),
            );
          },
        ),
      );

  get _body => Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              shrinkWrap: false,
              children: [
                _cartItems,
                _cartInfo,
              ],
            ),
          ),
          _checkoutButton
        ],
      );

  get _cartInfo => ControlledWidgetBuilder(
          builder: (BuildContext context, CartController controller) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.spacingNormal),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.spacingMedium),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        LocaleKeys.items
                            .tr(args: [controller.cart.total_qty.toString()]),
                        style: bodyTextNormal2.copyWith(
                            color: AppColors.neutralGray),
                      )),
                      Text(
                          Utility.currencyFormat(
                              controller.cart.net_total ?? 0),
                          style: bodyTextNormal1.copyWith(
                              color: AppColors.neutralDark)),
                    ],
                  ),
                  SizedBox(
                    height: Dimens.spacingNormal,
                  ),
                  DotWidget(
                    color: AppColors.neutralGray,
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
                        style: heading6.copyWith(color: AppColors.neutralDark),
                      )),
                      Text(
                          Utility.currencyFormat(
                              controller.cart.net_total ?? 0),
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

  get _cartItems => ControlledWidgetBuilder(
          builder: (BuildContext context, CartController controller) {
        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.cart.cart.length,
            itemBuilder: (BuildContext context, int index) {
              return CartItemView(
                controller.cart.cart[index],
                inStock: controller.cart.cart[index].product_id.stock > 0,
                onSelect: (CartItem cartItem) {
                  if (cartItem.product_id != null &&
                      cartItem.product_id.product_detail != null)
                    controller.showProductDetails(
                        cartItem.product_id.product_detail.id.toString());
                },
                onAdd: controller.updateCart,
                onRemove: controller.updateCart,
                onDelete: controller.removeItem,
              );
            });
      });

  get _checkoutButton => ControlledWidgetBuilder(
          builder: (BuildContext context, CartController controller) {
        return SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: AppColors.neutralLightGray,
                        width: Dimens.borderWidth))),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.spacingMedium,
                  vertical: Dimens.spacingNormal),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    Utility.currencyFormat(controller.cart.net_total),
                    style: captionNormal1,
                  )),
                  RaisedButton(
                    onPressed: () {
                      controller.checkout();
                    },
                    color: AppColors.primary,
                    child: Text(LocaleKeys.checkout.tr(), style: buttonText),
                  ),
                ],
              ),
            ),
          ),
        );
      });

  _isCartEmpty(CartController controller) {
    return controller.cart == null ||
        controller.cart.cart == null ||
        controller.cart.cart.length == 0;
  }
}
