import 'package:coupon_app/app/components/cart_item.dart';
import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/price.dart';
import 'package:coupon_app/app/components/product_thumbnail.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/checkout/checkout_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/data/repositories/cart/data_cart_repository.dart';
import 'package:coupon_app/data/repositories/data_address_repository.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:coupon_app/data/repositories/data_order_repository.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CheckoutPage extends View {


  CheckoutPage();

  @override
  State<StatefulWidget> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ViewState<CheckoutPage, CheckoutController> {
  _CheckoutPageState()
      : super(CheckoutController(
            DataAuthenticationRepository(),
            DataAddressRepository(),
            DataCartRepository(),
            DataOrderRepository()));

  @override
  Widget get view => Scaffold(
        key: globalKey,
        appBar: AppBar(
            title: Text(
          LocaleKeys.orderConfirm.tr(),
          style: heading5.copyWith(color: AppColors.primary),
        )),
        body: _body,
      );

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext context, CheckoutController controller) {
        return StateView(
            controller.isLoading ? EmptyState.LOADING : EmptyState.CONTENT,
            Column(
              children: [
                Flexible(
                    flex: 1,
                    child: ListView(
                      children: [
                        controller.addressRequired()
                            ? (controller.defaultAddress != null
                                ? _defaultAddress(controller)
                                : _addAddress)
                            : SizedBox(),
                        _orderDetails,
                        _useWalletBalance,
                        _paymentMethods
                      ],
                    )),
                _placeOrder
              ],
            ));
      });

  get _paymentMethods => ControlledWidgetBuilder(
          builder: (BuildContext context, CheckoutController controller) {
        return Container(
          color: AppColors.cardBg,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      LocaleKeys.payment.tr(),
                      style: heading5,
                    )),
                  ],
                ),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: Dimens.spacingNormal,
                    ),
                   /* !controller.containsCoupon
                        ? RadioListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(LocaleKeys.cashOnDeliver.tr()),
                            value: 1,
                            groupValue: controller.paymentMethod,
                            onChanged: controller.useWallet ? null :(int value) {
                              controller.setPaymentMethod(value);
                            },
                          )
                        : SizedBox(),*/
                    RadioListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(LocaleKeys.payOnline.tr()),
                      value: 2,
                      groupValue: controller.paymentMethod,
                      onChanged: (controller.useWallet && controller.amountToPay > 0)  || (!controller.useWallet)? (int value) {
                        controller.setPaymentMethod(value);
                      } : null,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });

  get _orderDetails => ControlledWidgetBuilder(
          builder: (BuildContext context, CheckoutController controller) {
        return controller.cart != null
            ? Container(
                color: AppColors.cardBg,
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.spacingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            LocaleKeys.orderDetails.tr(),
                            style: heading5,
                          )),
                          Text(
                            Utility.currencyFormat(controller.cart.net_total),
                            style: captionNormal2.copyWith(
                                color: AppColors.neutralGray),
                          ),
                        ],
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.cart.cart.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _productDetail(
                                controller.cart.cart[index], controller);
                          })
                    ],
                  ),
                ),
              )
            : SizedBox();
      });

  get _addAddress => ControlledWidgetBuilder(
          builder: (BuildContext context, CheckoutController controller) {
        return RaisedButton(
            elevation: 0,
            color: AppColors.neutralLightGray.withAlpha(120),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),
            onPressed: () {
              controller.addAddress();
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: Dimens.spacingNormal),
              child: Column(
                children: [
                  Icon(
                    MaterialCommunityIcons.plus_circle,
                    color: AppColors.neutralGray,
                  ),
                  Text(
                    controller.containsOnlyCoupon
                        ? LocaleKeys.addPersonalDetails.tr()
                        : LocaleKeys.addAddress.tr(),
                    style: buttonText.copyWith(
                      color: AppColors.neutralGray,
                    ),
                  )
                ],
              ),
            ));
      });

  get _useWalletBalance => ControlledWidgetBuilder(
          builder: (BuildContext context, CheckoutController controller) {
        return controller.currentUser != null ?  CheckboxListTile(
            activeColor: Colors.red,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal:  Dimens.spacingMedium,) ,
            controlAffinity: ListTileControlAffinity.leading,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    LocaleKeys.useWalletBalance.tr(),
                    style: captionNormal2,
                  ),
                ),
                Text(
                  Utility.currencyFormat(controller.currentUser.wallet_balance),
                  style: captionNormal1,
                )
              ],
            ),

            value: controller.useWallet,
            onChanged: controller.enableUseWallet ? (value) {
              controller.toggleUseWallet();
            } : null) : SizedBox();
      });

  get _placeOrder => ControlledWidgetBuilder(
          builder: (BuildContext context, CheckoutController controller) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: RaisedButton(
              onPressed: controller.paymentMethod != 0
                  ? () {
                      controller.placeOrder();
                    }
                  : null,
              child: Text(
                controller.paymentMethod == 2 &&  controller.amountToPay > 0
                    ? LocaleKeys.fmtPaySecurely.tr(args: [
                        controller.getAmountToPay()
                      ])
                    : LocaleKeys.placeOrder.tr(),
                style: buttonText,
              ),
            ),
          ),
        );
      });

  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }
    return string[0].toUpperCase() + string.substring(1);
  }

  _defaultAddress(CheckoutController controller) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.spacingMedium),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.spacingMedium, vertical: Dimens.spacingNormal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    controller.containsOnlyCoupon
                        ? LocaleKeys.shippingDetails.tr()
                        : LocaleKeys.deliveryAddress.tr(),
                    style: heading6.copyWith(color: AppColors.neutralDark),
                  )),
                  InkWell(
                    onTap: () {
                      controller.changeAddress();
                    },
                    child: Text(
                      controller.containsOnlyCoupon
                          ? LocaleKeys.changeDetails.tr()
                          : LocaleKeys.changeAddress.tr(),
                      style: captionNormal1.copyWith(color: AppColors.accent),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Dimens.spacingNormal,
              ),
              Text(
                "${capitalize(controller.defaultAddress.first_name)} ${capitalize(controller.defaultAddress.last_name)}",
                style: captionNormal1.copyWith(color: AppColors.neutralDark),
              ),
              SizedBox(
                height: Dimens.spacingSmall,
              ),
              controller.containsOnlyCoupon
                  ? Text(
                      controller.defaultAddress != null &&
                              controller.defaultAddress.email != null
                          ? controller.defaultAddress.email
                          : "",
                      style:
                          captionNormal2.copyWith(color: AppColors.neutralDark))
                  : Text(
                      Utility.addressFormatter(controller.defaultAddress),
                      style:
                          captionNormal2.copyWith(color: AppColors.neutralDark),
                    ),
              SizedBox(
                height: Dimens.spacingSmall,
              ),
              Text(
                LocaleKeys.fmtPhone
                    .tr(args: [controller.defaultAddress.phone_no]),
                style: captionNormal2.copyWith(color: AppColors.neutralDark),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _productDetail(CartItem cart, CheckoutController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.spacingNormal),
      child: InkWell(
        onTap: () {
          if (cart.product_id != null && cart.product_id.product_detail != null)
            controller.showProductDetails(
                cart.product_id.product_detail.id.toString());
        },
        child: Card(
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimens.spacingNormal),
                  child: cart.variant_value_id == null ? ProductThumbnail(
                      cart != null && cart.product_id != null
                          ? cart.product_id.thumb_img
                          : ""): ProductThumbnail(
                      cart != null
                          ? cart.variant_value_id.image
                          : "")
                  ,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Dimens.spacingNormal,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: Dimens.spacingMedium),
                        child: Text(
                          cart != null &&
                                  cart.product_id != null &&
                                  cart.product_id.product_detail != null
                              ? cart.product_id.product_detail.name ?? "-"
                              : "-",
                          maxLines: 1,
                          style:
                              heading6.copyWith(color: AppColors.neutralDark),
                        ),
                      ),
                      Visibility(
                        visible:  cart != null && cart.variant_value_id != null,
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: Dimens.spacingMedium),
                          child: Text(
                            cart != null && cart.variant_value_id != null ? cart.variant_value_id.value : "",
                            maxLines: 1,
                            style:
                            captionNormal1.copyWith(color: AppColors.neutralGray),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.spacingSmall,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: Dimens.spacingMedium),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                LocaleKeys.fmtQty
                                    .tr(args: [cart.qty.toString()]),
                                style: captionNormal1.copyWith(
                                    color: AppColors.neutralGray),
                              ),
                            ),
                            Visibility(
                                visible: cart.product_id.stock > 0,
                                child: Price(product: cart.product_id, variantValue: cart.variant_value_id,)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Dimens.spacingMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
