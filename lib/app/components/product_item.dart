import 'dart:async';

import 'package:coupon_app/app/components/app_image.dart';
import 'package:coupon_app/app/components/buy_now_button.dart';
import 'package:coupon_app/app/components/countdown.dart';
import 'package:coupon_app/app/components/rating.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProductItem extends StatefulWidget {
  final ProductDetail product;

  ProductItem({
    @required this.product,
  });

  @override
  State<StatefulWidget> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem>
    with TickerProviderStateMixin {
  final _cartStream = CartStream();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: InkWell(
          onTap: () {
            //if (widget.coupon != null)
            AppRouter().productDetails(context, widget.product);
          },
          child: _buildProductCard(),
        ));
  }

  Widget _buildProductCard() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
                width: double.infinity,
                height: Dimens.thumbImageHeight,
                child: AppImage(widget.product.product != null
                    ? widget.product.product.thumb_img
                    : "")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.spacingMedium,
                vertical: Dimens.spacingNormal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Text(
                    widget.product != null && widget.product.name != null
                        ? widget.product.name
                        : "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: bodyTextNormal1.copyWith(color: AppColors.primary),
                  ),
                ),
                /*Text(
                  widget.product != null &&
                          widget.product.short_description != null
                      ? widget.product.short_description
                      : "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: captionNormal1.copyWith(color: AppColors.neutralGray),
                ),*/
                SizedBox(
                  height: Dimens.spacingSmall,
                ),
                _countdownView(widget.product),
                SizedBox(
                  height: Dimens.spacingSmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.product != null &&
                                double.parse(widget.product.product.dis_per) > 0
                            ? Text(
                                Utility.currencyFormat(widget.product != null
                                    ? widget.product.product.price
                                    : "0"),
                                style: captionNormal2.copyWith(
                                    color: AppColors.neutralGray,
                                    decoration: TextDecoration.lineThrough),
                              )
                            : SizedBox(),
                        Text(
                          Utility.currencyFormat(widget.product != null
                              ? widget.product.product.sale_price
                              : "0"),
                          style: bodyTextNormal1.copyWith(
                              color: AppColors.primary),
                        )
                      ],
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    InkWell(
                      child: Icon(
                        MaterialCommunityIcons.cart_plus,
                        color: AppColors.accent,
                      ),
                      onTap: () {
                        showGenericSnackbar(
                            context, LocaleKeys.itemAddedToCart.tr());
                        _cartStream.addToCart(widget.product.product, null);
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _countdownView(ProductDetail product) {
    if (product.product == null) return SizedBox();
    if (product.product.valid_to != null &&
        product.product.valid_from != null) {
      return CountdownView(
        validFrom: DateHelper.parseServerDateTime(product.product.valid_from),
        validTo: DateHelper.parseServerDateTime(product.product.valid_to),
      );
    }
    return SizedBox();
  }
}
