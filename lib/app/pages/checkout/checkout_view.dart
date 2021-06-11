import 'package:coupon_app/app/components/cart_item.dart';
import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/product_thumbnail.dart';
import 'package:coupon_app/app/pages/checkout/checkout_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/data/repositories/cart/data_cart_repository.dart';
import 'package:coupon_app/data/repositories/data_address_repository.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CheckoutPage extends View {
  @override
  State<StatefulWidget> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ViewState<CheckoutPage, CheckoutController> {
  _CheckoutPageState()
      : super(
            CheckoutController(DataAddressRepository(), DataCartRepository()));

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
        return Column(
          children: [
            Flexible(
                flex: 1,
                child: ListView(
                  children: [
                    controller.defaultAddress != null
                        ? _defaultAddress(controller)
                        : _addAddress,
                    _orderDetails,
                    _paymentMethods
                  ],
                )),
            _placeOrder
          ],
        );
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
                    RadioListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(LocaleKeys.cashOnDeliver.tr()),
                      value: 1,
                      groupValue: controller.paymentMethod,
                      onChanged: (int value) {
                        controller.setPaymentMethod(value);
                      },
                    ),
                    RadioListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(LocaleKeys.payOnline.tr()),
                      value: 2,
                      groupValue: controller.paymentMethod,
                      onChanged: (int value) {
                        controller.setPaymentMethod(value);
                      },
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
                      LocaleKeys.orderDetails.tr(),
                      style: heading5,
                    )),
                    Text(
                      Utility.currencyFormat(controller.cart.net_total),
                      style:
                          captionNormal2.copyWith(color: AppColors.neutralGray),
                    ),
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.cart.cart.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _productDetail(controller.cart.cart[index]);
                    })
              ],
            ),
          ),
        );
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
                    LocaleKeys.addAddress.tr(),
                    style: buttonText.copyWith(
                      color: AppColors.neutralGray,
                    ),
                  )
                ],
              ),
            ));
      });

  get _placeOrder => ControlledWidgetBuilder(
          builder: (BuildContext context, CheckoutController controller) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: RaisedButton(
              onPressed: controller.paymentMethod != 0 ? () {} : null,
              child: Text(controller.paymentMethod == 2
                  ? LocaleKeys.fmtPaySecurely.tr(
                      args: [Utility.currencyFormat(controller.cart.net_total)])
                  : LocaleKeys.placeOrder.tr(), style: buttonText,),
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
                    LocaleKeys.deliveryAddress.tr(),
                    style: heading6.copyWith(color: AppColors.neutralDark),
                  )),
                  InkWell(
                    onTap: () {
                      controller.changeAddress();
                    },
                    child: Text(
                      LocaleKeys.changeAddress.tr(),
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
              Text(
                "${controller.defaultAddress.floor_flat}, ${controller.defaultAddress.block.block_name}, " +
                    "${controller.defaultAddress.building}, ${controller.defaultAddress.address}" +
                    "${controller.defaultAddress.area.area_name}",
                style: captionNormal2.copyWith(color: AppColors.neutralDark),
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

  _productDetail(CartItem cart) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.spacingNormal),
      child: Card(
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(Dimens.spacingNormal),
                child: ProductThumbnail(cart != null && cart.product_id != null
                    ? cart.product_id.thumb_img
                    : ""),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimens.spacingMedium,
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
                        style: heading6.copyWith(color: AppColors.neutralDark),
                      ),
                    ),
                    SizedBox(
                      height: Dimens.spacingNormal,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: Dimens.spacingMedium),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.fmtQty.tr(args: [cart.qty.toString()]),
                              style: captionNormal1.copyWith(
                                  color: AppColors.neutralGray),
                            ),
                          ),
                          Text(
                            Utility.getCartItemPrice(cart),
                            style: heading6.copyWith(color: AppColors.primary),
                          ),
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
    );
  }
}
