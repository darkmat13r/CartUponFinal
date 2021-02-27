import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupon_app/app/components/banner_product.dart';
import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/product_colors.dart';
import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/components/product_sizes.dart';
import 'package:coupon_app/app/components/rating.dart';
import 'package:coupon_app/app/components/review.dart';
import 'package:coupon_app/app/components/social_share.dart';
import 'package:coupon_app/app/pages/product/product_controller.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductPage extends View {
  final ProductEntity product;

  ProductPage(this.product);

  @override
  State<StatefulWidget> createState() => ProductPageView();
}

class ProductPageView extends ViewState<ProductPage, ProductController> {
  ProductPageView() : super(ProductController());

  @override
  Widget get view => Scaffold(
        key: globalKey,
        appBar: customAppBar(
            title: Text(
          widget.product != null ? widget.product.name : "",
          style: heading5.copyWith(color: AppColors.primary),
        )),
        body: _body,
      );

  String variantSelected = null;
  int sliderImageIndex = 0;

  get _productDetails => ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CarouselSlider.builder(
              itemCount: widget.product.images.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: widget.product.images[index].startsWith("http")
                        ? Image.network(
                            widget.product.images[index],
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            widget.product.images[index],
                            fit: BoxFit.fill,
                          ));
              },
              options: CarouselOptions(
                height: 240,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                onPageChanged: (index, page) {
                  setState(() {
                    sliderImageIndex = index;
                  });
                },
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
                  count:  widget.product.images.length,
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
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "KD${widget.product != null ? widget.product.price : ""}",
                              style: bodyTextMedium2.copyWith(
                                  color: AppColors.neutralGray,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(
                              "KD${widget.product != null ? widget.product.price : ""}",
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
                  widget.product != null ? widget.product.name : "",
                  style: heading3.copyWith(color: AppColors.primary),
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                Text(
                  widget.product != null ? widget.product.description : "",
                  style: heading4.copyWith(
                      color: AppColors.primary, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                Text(
                  "Product Description",
                  style: bodyTextMedium2.copyWith(
                      color: AppColors.neutralGray,
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
                    Icon(MaterialCommunityIcons.timer),
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
                            style: bodyTextMedium2,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Icon(MaterialCommunityIcons.heart_outline),
                            label: Text(
                              "Add to Whishlist",
                              style: buttonText.copyWith(
                                  color: AppColors.neutralGray),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dimens.spacingLarge,
                        ),
                        Expanded(
                          child: RaisedButton.icon(
                            onPressed: () {
                              CartStream().addToCart();
                            },
                            icon: Icon(
                              MaterialCommunityIcons.cart_plus,
                              color: AppColors.neutralLight,
                            ),
                            label: Text(
                              "Buy Now",
                              style: buttonText,
                            ),
                          ),
                        )
                      ],
                    )),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                SocialShareButtons()
              ],
            ),
          )
        ],
      );

  get _reviews => ControlledWidgetBuilder(
        builder: (BuildContext context, ProductController controller) {
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    LocaleKeys.reviewProduct.tr() + ":",
                    style: heading5.copyWith(color: AppColors.neutralDark),
                  ),
                  Expanded(child: SizedBox()),
                  TextButton(
                    onPressed: () {
                      controller.reviews();
                    },
                    child: Text(
                      LocaleKeys.seeMore.tr(),
                      style: linkText,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Rating(
                    size: 20,
                  ),
                  Text("4.5",
                      style: captionNormal1.copyWith(
                          color: AppColors.neutralGray)),
                  Text(" (5 Review)",
                      style: captionNormal2.copyWith(
                          color: AppColors.neutralGray)),
                ],
              ),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              ReviewItem(),
            ],
          );
        },
      );

  Widget _recommended(String name) => ControlledWidgetBuilder(
          builder: (BuildContext context, ProductController controller) {
        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    name,
                    style: heading5.copyWith(color: AppColors.primary),
                  )),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      LocaleKeys.seeMore.tr(),
                      style: linkText.copyWith(color: AppColors.accent),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 305,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.similarProducts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width/2.1,
                    child: ProductItem(
                        product: controller.similarProducts[index],
                        onClickItem: () {}),
                  );
                },
              ),
            )
          ],
        );
      });

  get _body => ListView(
        children: [_productDetails, _recommended("Similar Products")],
      );
}
