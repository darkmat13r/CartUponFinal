import 'dart:async';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupon_app/app/components/app_image.dart';
import 'package:coupon_app/app/components/buy_now_button.dart';
import 'package:coupon_app/app/components/product_colors.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
import 'package:coupon_app/app/utils/dummy.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerProduct extends StatefulWidget {
  final bool showDescription = false;

  @override
  State<StatefulWidget> createState() => _BannerProductState();
}

class _BannerProductState extends State<BannerProduct> {
  String variantSelected = null;
  ProductEntity product = DummyProducts.products()[
      Random().nextInt(DummyProducts.products().length)];
  String _elapsedTime;
  final _cartStream = CartStream();
  int sliderImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (_isValidToValid()) {
      _elapsedTime =
          DateHelper.formatExpiry(DateTime.now(), product.productId.validTo);
    }
    _createTimer();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            CarouselSlider.builder(
                itemCount: product != null
                    ? product.productId.productGallery.length
                    : 0,
                itemBuilder: (BuildContext context, int index) {
                  var gallery = product.productId.productGallery ?? [];
                  return AppImage(gallery[index].image);
                },
                options: CarouselOptions(
                  height: 240,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  onPageChanged: (index, page) {
                    setState(() {
                      sliderImageIndex = index;
                    });
                  },
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  scrollDirection: Axis.horizontal,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSmoothIndicator(
                    activeIndex: sliderImageIndex,
                    count: product != null
                        ? product.productId.productGallery.length
                        : 0,
                    effect: WormEffect(dotWidth: 8, dotHeight: 8),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimens.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              product != null &&
                                      double.parse(product.productId.disPer) > 0
                                  ? Text(
                                      "KD${product != null ? product.productId.price : ""}",
                                      style: captionNormal2.copyWith(
                                          color: AppColors.neutralGray,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    )
                                  : SizedBox(),
                              Text(
                                "KD${product.productId.salePrice}",
                                style:
                                    heading4.copyWith(color: AppColors.primary),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Image.asset(
                              Resources.offerTag,
                              height: 36,
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 0, left: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    product != null &&
                                            double.parse(product.productId.disPer) >0
                                        ? Text(
                                            "${product.productId.disPer}%\nOFF",
                                            style: heading5.copyWith(
                                                color: AppColors.neutralLight,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w900))
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  Text(
                    product.name,
                    style: heading3.copyWith(color: AppColors.primary),
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  Text(
                    product.shortDescription,
                    style: heading4.copyWith(
                        color: AppColors.primary, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.neutralGray)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.spacingMedium),
                        child: DropdownButton<String>(
                          elevation: 8,
                          underline: SizedBox(),
                          hint: Text("2 Person"),
                          value: variantSelected,
                          isExpanded: true,
                          icon: Icon(MaterialIcons.arrow_drop_down),
                          items: <String>[
                            '2 Person',
                            '4 Person',
                            '8 Person',
                            '9 Person'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value,
                                    style: heading6.copyWith(
                                        color: AppColors.neutralDark),
                                  ),
                                  Text(
                                    "KD9",
                                    style: captionNormal1.copyWith(
                                        color: AppColors.neutralGray),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              variantSelected = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child:_elapsedTime != null ? Row(
                          children: [
                            Image.asset(
                              Resources.timerIcon,
                              width: 24,
                              height: 24,
                              color: AppColors.primary,
                            ),
                            SizedBox(
                              width: Dimens.spacingMedium,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "TIME LEFT",
                                    style: heading6.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    _elapsedTime != null ? _elapsedTime : "",
                                    style: bodyTextNormal2.copyWith(
                                        color: AppColors.primary, fontSize: 12),
                                  )
                                ],
                              ),
                            )
                          ],
                        ): SizedBox(),
                      ) ,
                      BuyNowButton()
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isValidToValid() =>
      product != null &&
      product.productId != null &&
      product.productId.validTo != null;

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
        if (mounted) {
          setState(() {
            _elapsedTime = DateHelper.formatExpiry(
                DateTime.now(), product.productId.validTo);
          });
        } else {
          _timer.cancel();
        }
      });
    }
  }
}
