import 'dart:async';

import 'package:coupon_app/app/components/buy_now_button.dart';
import 'package:coupon_app/app/components/rating.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/coupons/coupon_entity.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CouponItem extends StatefulWidget {
  final Function onClickItem;
  final CouponEntity coupon;

  CouponItem({
    @required this.coupon,
    @required this.onClickItem,
  });

  @override
  State<StatefulWidget> createState() => CouponItemState();
}

class CouponItemState extends State<CouponItem> {
  String _elapsedTime;

  @override
  Widget build(BuildContext context) {
    if (_isValidToValid()) {
      _elapsedTime = DateHelper.formatExpiry(
          DateTime.now(), widget.coupon.couponId.validTo);
    }
    _createTimer();
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: InkWell(
          onTap: () {
            //if (widget.coupon != null)
            // AppRouter().productDetails(context, widget.coupon);
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
                      child: widget.coupon != null &&
                              widget.coupon.couponId.thumbImg.startsWith("http")
                          ? Image.network(
                              widget.coupon != null
                                  ? widget.coupon.couponId.thumbImg
                                  : "",
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              widget.coupon != null
                                  ? widget.coupon.couponId.thumbImg
                                  : "",
                              fit: BoxFit.fill,
                            )),
                  SizedBox(
                    height: Dimens.spacingNormal,
                  ),
                  Text(
                    widget.coupon != null ? widget.coupon.name : "",
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
                          Text(
                            "KD${widget.coupon != null ? widget.coupon.couponId.price : ""}",
                            style: captionNormal2.copyWith(
                                color: AppColors.neutralGray,
                                decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            "KD${widget.coupon != null ? widget.coupon.couponId.price : ""}",
                            style: bodyTextMedium1.copyWith(
                                color: AppColors.primary),
                          )
                        ],
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      BuyNowButton(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  bool _isValidToValid() =>
      widget.coupon != null &&
      widget.coupon.couponId != null &&
      widget.coupon.couponId.validTo != null;

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
        setState(() {
          _elapsedTime = DateHelper.formatExpiry(
              DateTime.now(),
              widget.coupon.couponId.validTo);
        });
      });
    }
  }
}
