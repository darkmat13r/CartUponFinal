import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupon_app/app/components/buy_now_button.dart';
import 'package:coupon_app/app/components/product_colors.dart';
import 'package:coupon_app/app/utils/constants.dart';
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

  int sliderImageIndex  = 0;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [
              CarouselSlider.builder(
                  itemCount: product.images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: product.images[index].startsWith("http")
                            ? Image.network(product.images[index], fit: BoxFit.cover,)
                            : Image.asset(product.images[index], fit: BoxFit.cover,));
                  },
                  options: CarouselOptions(
                    height: 240,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    onPageChanged: (index, page){
                      setState(() {
                        sliderImageIndex =  index;
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
                      count:  product.images.length,
                      effect: WormEffect(
                          dotWidth: 8,
                          dotHeight: 8
                      ),
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
                      width:double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "KD9.5",
                                  style: bodyTextMedium2.copyWith(
                                      color: AppColors.neutralGray,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                Text(
                                  "KD5.5",
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
                                  padding: const EdgeInsets.only(right: 0, left: 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("44%\nOFF",
                                          style: heading5.copyWith(
                                              color: AppColors.neutralLight,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900)),
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
                      "Powerey 10000mAh Power Bank with Built-in Cable ",
                      style: heading3.copyWith(color: AppColors.primary),
                    ),
                    SizedBox(
                      height: Dimens.spacingMedium,
                    ),
                    Text(
                      "Built-in Lightning, Type-C, and also Micro-USB cable",
                      style: heading4.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w400),
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
                                "04h: 39m : 21s",
                                style: bodyTextNormal1,
                              )
                            ],
                          ),
                        ),
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
