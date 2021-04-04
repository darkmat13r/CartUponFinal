import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupon_app/app/components/app_image.dart';
import 'package:coupon_app/app/components/banner_product.dart';
import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/product_colors.dart';
import 'package:coupon_app/app/components/product_sizes.dart';
import 'package:coupon_app/app/components/rating.dart';
import 'package:coupon_app/app/components/review.dart';
import 'package:coupon_app/app/components/social_share.dart';
import 'package:coupon_app/app/components/variant_picker.dart';
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
  State<StatefulWidget> createState() => ProductPageView(this.product);
}

class ProductPageView extends ViewState<ProductPage, ProductController> {
  ProductPageView(product) : super(ProductController(product));
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



  get _productDetails => ControlledWidgetBuilder(builder: (BuildContext context, ProductController controller){
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        CarouselSlider.builder(
            itemCount: widget.product != null
                ? widget.product.productId.productGallery.length
                : 0,
            itemBuilder: (BuildContext context, int index) {
              var gallery = widget.product.productId.productGallery ?? [];
              return AppImage(gallery[index].image);
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
                count: widget.product != null
                    ? widget.product.productId.productGallery.length
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
                          widget.product != null && double.parse(widget.product.productId.disPer) > 0 ? Text(
                            "KD${widget.product != null ? widget.product.productId.price : ""}",
                            style: bodyTextMedium2.copyWith(
                                color: AppColors.neutralGray,
                                decoration: TextDecoration.lineThrough),
                          ) : SizedBox(),
                          Text(
                            "KD${widget.product != null ? widget.product.productId.salePrice : ""}",
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
                                widget.product != null && double.parse(widget.product.productId.disPer) > 0 ? Text("${widget.product.productId.disPer}%\nOFF",
                                    style: heading5.copyWith(
                                        color: AppColors.neutralLight,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900)) : SizedBox(),
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
                style: heading4.copyWith(color: AppColors.primary),
              ),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              Text(
                widget.product != null
                    ? widget.product.shortDescription
                    : "",
                style: heading5.copyWith(
                    color: AppColors.primary, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: Dimens.spacingMedium,
              ),

              SizedBox(
                height: Dimens.spacingMedium,
              ),
              widget.product != null ?  VariantPicker(widget.product.productId.productVariants) :SizedBox(),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child:controller.elapsedTime != null ? Row(
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
                                controller.elapsedTime != null ? controller.elapsedTime : "",
                                style: bodyTextNormal2.copyWith(
                                    color: AppColors.primary, fontSize: 12),
                              )
                            ],
                          ),
                        )
                      ],
                    ): SizedBox(),
                  ) ,
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
                            "Whishlist",
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
                            CartStream().addToCart(widget.product);
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
              SocialShareButtons(),
              Text("Description", style: heading6,),
              Text(
                widget.product != null
                    ? widget.product.fullDescription
                    : "",
                style: bodyTextMedium2.copyWith(
                    color: AppColors.neutralGray,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        )
      ],
    );
  });

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
              height: 280,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.similarProducts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ProductItem(
                        product: controller.similarProducts[index],
                        ),
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
