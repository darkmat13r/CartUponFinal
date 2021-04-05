import 'dart:async';

import 'package:coupon_app/app/components/app_image.dart';
import 'package:coupon_app/app/components/buy_now_button.dart';
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
  String _elapsedTime;
  final _cartStream =CartStream();
  @override
  Widget build(BuildContext context) {
    if (_isValidToValid()) {
      _elapsedTime = DateHelper.formatExpiry(
          DateTime.now(), widget.product.product.valid_to);
    }
    _createTimer();
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: InkWell(
          onTap: () {
            //if (widget.coupon != null)
             AppRouter().productDetails(context, widget.product);
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.spacingMedium),
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
                      child: AppImage(widget.product.product.thumb_img)),
                  SizedBox(
                    height: Dimens.spacingNormal,
                  ),
                  Text(
                    widget.product != null ? widget.product.name : "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: heading6.copyWith(color: AppColors.primary),
                  ),
                  SizedBox(
                    height: Dimens.spacingNormal,
                  ),
                  _elapsedTime != null
                      ? Row(
                          children: [
                            Image.asset(
                              Resources.timerIcon,
                              width: 16,
                              height: 16,
                              color: AppColors.primary,
                            ),
                            SizedBox(
                              width: Dimens.spacingNormal,
                            ),
                            Text(
                              _elapsedTime != null ? _elapsedTime : "",
                              style: bodyTextNormal2.copyWith(
                                  color: AppColors.primary, fontSize: 12),
                            )
                          ],
                        )
                      : SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.product != null && double.parse(widget.product.product.dis_per) > 0 ? Text(
                            "KD${widget.product != null ? widget.product.product.price : ""}",
                            style: captionNormal2.copyWith(
                                color: AppColors.neutralGray,
                                decoration: TextDecoration.lineThrough),
                          ) : SizedBox(),
                          Text(
                            "KD${widget.product != null ? widget.product.product.sale_price : ""}",
                            style: bodyTextMedium1.copyWith(
                                color: AppColors.primary),
                          )
                        ],
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      BuyNowButton(
                        onAddToCart: (){
                          _cartStream.addToCart(widget.product);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  bool _isValidToValid() =>
      widget.product != null &&
      widget.product.product != null &&
      widget.product.product.valid_to != null;

  Timer _timer;

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  void deactivate() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.deactivate();
  }

  _createTimer() {
    if (_isValidToValid()) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
       if(mounted){
         setState(() {
           _elapsedTime = DateHelper.formatExpiry(
               DateTime.now(), widget.product.product.valid_to);
         });
       }else{
         _timer.cancel();
       }
      });
    }
  }
}
