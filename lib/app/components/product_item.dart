import 'dart:async';

import 'package:coupon_app/app/components/app_image.dart';
import 'package:coupon_app/app/components/buy_now_button.dart';
import 'package:coupon_app/app/components/countdown.dart';
import 'package:coupon_app/app/components/rating_bar.dart';
import 'package:coupon_app/app/components/variant_picker.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/data/repositories/data_product_repository.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';
import 'package:coupon_app/domain/entities/models/ProductWithRelated.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItem extends StatefulWidget {
  final ProductDetail product;
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  ProductItem({
    @required this.product,
  });

  @override
  State<StatefulWidget> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem>
    with TickerProviderStateMixin {
  final _cartStream = CartStream();
  bool _showTimer = false;

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      _showTimer = _isValidToValid();
    }
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: InkWell(
          onTap: () {
            //if (widget.coupon != null)
            AppRouter().productDetails(context, widget.product);
            widget.analytics.logViewItem(
              items: [
                AnalyticsEventItem(
                  itemId: widget.product.product.id.toString(),
                  itemName: widget.product.name,
                  itemCategory: widget.product.product.category != null
                      ? widget.product.product.category.category_title
                      : widget.product.product.category_id.toString(),
                )
              ],
              value: double.tryParse(
                  widget.product.product.getVariantOfferPriceByVariant(null)),
              currency: 'KD',
            );
          },
          child: _buildProductCard(),
        ));
  }

  Widget _buildProductCard() {
    return Card(
      child: widget.product.product != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1/1,
                  child: AppImage(
                    widget.product.product != null
                        ? widget.product.product.thumb_img
                        : "",
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(child: SizedBox(),),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.spacingMedium,
                      vertical: Dimens.spacingNormal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height : 40.h,
                        child: Text(
                          widget.product != null &&
                                  widget.product.name != null
                              ? widget.product.name
                              : "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,

                          style: bodyTextNormal1.copyWith(
                              color: AppColors.primary),
                        ),
                      ),

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
                              Visibility(
                                visible: widget.product.product != null &&
                                    widget.product.product.stock <= 0,
                                child: Text(
                                  LocaleKeys.outOfStock.tr(),
                                  style: captionNormal2.copyWith(
                                      color: AppColors.error),
                                ),
                              ),
                              Utility.checkOfferPrice(
                                      widget.product != null
                                          ? widget.product.product
                                          : null,
                                      _showTimer)
                                  ? Text(
                                      Utility.currencyFormat(
                                          widget.product != null
                                              ? widget.product.product.price
                                              : "0"),
                                      style: captionNormal2.copyWith(
                                          color: AppColors.neutralGray,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    )
                                  : SizedBox(),
                              Text(
                                Utility.currencyFormat(widget.product != null
                                    ? _showTimer &&
                                            widget.product.product
                                                    .offer_price !=
                                                "0"
                                        ? widget.product.product.offer_price
                                        : widget.product.product.sale_price
                                    : 0),
                                style: bodyTextNormal1.copyWith(
                                    color: AppColors.primary),
                              )
                            ],
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          Visibility(
                            visible: widget.product.product != null &&
                                widget.product.product.stock > 0,
                            child: InkWell(
                              child: Icon(
                                MaterialCommunityIcons.cart_plus,
                                color: AppColors.accent,
                              ),
                              onTap: () {
                                /* showGenericSnackbar(
                              context, LocaleKeys.itemAddedToCart.tr());*/
                                addToCart();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(child: SizedBox(),
                ),
              ],
            )
          : SizedBox(),
    );
  }

  ProductVariantValue selectedVariant;
  Future<void> addToCart() async {
    try {
      if(widget.product.product != null && widget.product.product.product_variants != null ){
        if(!widget.product.product.isVariantRequired()){
           await _cartStream.addToCart(widget.product.product, null);
        return;
        }
      }
      showLoadingDialog(context);
      ProductWithRelated productDetail = await DataProductRepository().getProductWithRelated(id : widget.product.id.toString());
      dismissDialog();
      if(!productDetail.productDetail.product.isVariantRequired()){
        await _cartStream.addToCart(widget.product.product, null);
        return;
      }
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 240,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: VariantPicker(
                       productDetail.productDetail.product.product_variants,
                       product: productDetail.productDetail.product,
                   onPickVariant: (variant){
                     selectedVariant = variant;
                   },),
                 ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      child:  Text(LocaleKeys.addToCart.tr(), style: buttonText,),
                      onPressed: ()  async {
                        if(selectedVariant == null){
                          showGenericDialog(context, LocaleKeys.error.tr(),
                              LocaleKeys.errorSelectVariant.tr(args: [productDetail.productDetail.product.getRequiredVariant().name.toLowerCase()]));
                          return;
                        }
                        Navigator.of(context).pop();
                        await _cartStream.addToCart(widget.product.product, selectedVariant);
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );

    } catch (e) {
      showGenericDialog(context, LocaleKeys.error.tr(), e.message);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isValidToValid() {
    if (widget.product.product == null) return false;
    var isValid = false;
    if (widget.product.product.offer_from == null ||
        widget.product.product.offer_to == null) {
      return false;
    }
    var validFrom = widget.product.product.offer_from;
    var validTo = widget.product.product.offer_to;
    return DateHelper.isValidTime(DateHelper.parseServerDateTime(validFrom),
        DateHelper.parseServerDateTime(validTo));
  }

  _countdownView(ProductDetail product) {
    if (product.product == null) return SizedBox();
    if (product.product.offer_from != null &&
        product.product.offer_to != null) {
      return Visibility(
          visible: true,
          child: CountdownView(
            isValidTime: (showTimer) {
              setState(() {
                _showTimer = showTimer;
              });
            },
            validFrom:
                DateHelper.parseServerDateTime(product.product.offer_from),
            validTo: DateHelper.parseServerDateTime(product.product.offer_to),
          ));
    }
    return SizedBox();
  }
}
