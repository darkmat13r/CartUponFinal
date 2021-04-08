import 'dart:async';

import 'package:coupon_app/app/components/app_image.dart';
import 'package:coupon_app/app/components/buy_now_button.dart';
import 'package:coupon_app/app/components/countdown.dart';
import 'package:coupon_app/app/components/rating.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
import 'package:coupon_app/app/utils/router.dart';
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
  State<StatefulWidget> createState() => ProductItemState();
}

class ProductItemState extends State<ProductItem> {
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
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: double.infinity,
                    height: 140,
                    decoration: const BoxDecoration(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(Dimens.cornerRadius)),
                        color: AppColors.neutralLight),
                    child: AppImage(widget.product.product != null ? widget.product.product.thumb_img : "")),
                Padding(
                  padding: const EdgeInsets.all(Dimens.spacingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product != null ? widget.product.name : "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: bodyTextNormal1,
                      ),
                      SizedBox(
                        height: Dimens.spacingSmall,
                      ),
                      _countdownView(widget.product),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.product != null &&
                                  double.parse(widget.product.product.dis_per) >
                                      0
                                  ? Text(
                                "KD${widget.product != null ? widget.product.product.price : ""}",
                                style: captionNormal2.copyWith(
                                    color: AppColors.neutralGray,
                                    decoration: TextDecoration.lineThrough),
                              )
                                  : SizedBox(),
                              Text(
                                "KD${widget.product != null ? widget.product.product.sale_price : ""}",
                                style: bodyTextNormal1.copyWith(
                                    color: AppColors.primary),
                              )
                            ],
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          IconButton(
                            icon: Icon(MaterialCommunityIcons.cart_plus),
                            color: AppColors.accent,
                            onPressed: () {
                              _cartStream.addToCart(widget.product, null);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _countdownView(ProductDetail product) {
    if(product.product == null) return SizedBox();
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
