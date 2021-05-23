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
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/components/variant_picker.dart';
import 'package:coupon_app/app/pages/product/product_controller.dart';
import 'package:coupon_app/app/pages/searchable_view_state.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/data/repositories/data_product_repository.dart';
import 'package:coupon_app/data/repositories/data_whishlist_repository.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductPage extends View {
  final ProductDetail product;

  ProductPage(this.product);

  @override
  State<StatefulWidget> createState() => ProductPageView(this.product);
}

class ProductPageView extends SearchableViewState<ProductPage, ProductController> {
  ProductPageView(product)
      : super(ProductController(
            product, DataProductRepository(), DataWhishlistRepository()));

  @override
  Widget get title => Text(
      widget.product != null ? widget.product.name : "",
      style: heading5.copyWith(color: AppColors.primary));

  @override
  Widget get body => _view;
  @override
  get key => globalKey;

  String variantSelected = null;
  int sliderImageIndex = 0;

  get _productDetails => ControlledWidgetBuilder(
          builder: (BuildContext context, ProductController controller) {
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            controller.product != null &&
                    controller.product.product != null &&
                    controller.product.product.product_gallery != null &&
                controller.product.product.product_gallery.length > 0
                ? CarouselSlider.builder(
                    itemCount: controller.product.product.product_gallery.length,
                    itemBuilder: (BuildContext context, int index) {
                      var gallery =
                          controller.product.product.product_gallery ?? [];
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
                    ))
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.product != null &&
                      controller.product.product != null &&
                      controller.product.product.product_gallery != null
                  &&  controller.product.product.product_gallery.length > 0
                      ?AnimatedSmoothIndicator(
                    activeIndex: sliderImageIndex,
                    count:  controller.product.product.product_gallery.length,
                    effect: WormEffect(dotWidth: 8, dotHeight: 8),
                  ) : SizedBox()
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
                              controller.product != null &&
                                      double.parse(controller
                                              .product.product.dis_per) >
                                          0
                                  ? Text(
                                      Utility.currencyFormat(
                                          controller.product != null
                                              ? controller.product.product.price
                                              : 0),
                                      style: captionNormal1.copyWith(
                                          color: AppColors.neutralGray,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    )
                                  : SizedBox(),
                              Text(
                                Utility.currencyFormat(
                                    controller.product != null
                                        ? controller.product.product.sale_price
                                        : 0),
                                style: bodyTextNormal1.copyWith(
                                    color: AppColors.primary),
                              )
                            ],
                          ),
                        ),
                        controller.product != null &&
                                double.parse(
                                        controller.product.product.dis_per) >
                                    0
                            ? Stack(
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
                                      padding: const EdgeInsets.only(
                                          right: 0, left: 16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${NumberFormat("#.##").format(double.parse(controller.product.product.dis_per))}%\nOFF",
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
                            : SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  Text(
                    controller.product != null ? controller.product.name : "",
                    style: heading5.copyWith(color: AppColors.primary),
                  ),
                  SizedBox(
                    height: Dimens.spacingSmall,
                  ),
                  Text(
                    controller.product != null
                        ? controller.product.short_description
                        : "",
                    style: bodyTextNormal1.copyWith(
                        color: AppColors.primary, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  controller.product != null
                      ? VariantPicker(
                          controller.product.product.product_variants,
                          onPickVariant: controller.onSelectVariant,
                        )
                      : SizedBox(),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  _eleapsedTime(controller),
                  SizedBox(
                    height: Dimens.spacingLarge,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          _whishlistButton(controller),
                          SizedBox(
                            width: Dimens.spacingLarge,
                          ),
                          _addToCartButton(controller)
                        ],
                      )),
                  SizedBox(
                    height: Dimens.spacingLarge,
                  ),
                  SocialShareButtons(),
                  SizedBox(
                    height: Dimens.spacingLarge,
                  ),
                  Text(
                    LocaleKeys.description.tr(),
                    style: heading6,
                  ),
                  SizedBox(
                    height: Dimens.spacingNormal,
                  ),
                  Html(
                    data: controller.product != null
                        ? controller.product.full_description
                        : "",
                    shrinkWrap: true,
                  ),
                ],
              ),
            )
          ],
        );
      });

  Row _eleapsedTime(ProductController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: controller.elapsedTime != null
              ? Row(
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
                            LocaleKeys.timeLeft.tr(),
                            style: bodyTextMedium1.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            controller.elapsedTime != null
                                ? controller.elapsedTime
                                : "",
                            style: bodyTextNormal2.copyWith(
                                color: AppColors.primary, fontSize: 12),
                          )
                        ],
                      ),
                    )
                  ],
                )
              : SizedBox(),
        ),
      ],
    );
  }

  Expanded _addToCartButton(ProductController controller) {
    return Expanded(
      child: RaisedButton.icon(
        onPressed: () {
          CartStream().addToCart(
              controller.product.product, controller.selectedProductVariant);
        },
        icon: Icon(
          MaterialCommunityIcons.cart_plus,
          color: AppColors.neutralLight,
        ),
        label: Text(
          LocaleKeys.buyNow.tr(),
          style: buttonText,
        ),
      ),
    );
  }

  Expanded _whishlistButton(ProductController controller) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () {
          controller.addItemToWhishlist(controller.product.product);
        },
        icon: Icon(!controller.isAddedToWhishlist
            ? MaterialCommunityIcons.heart_outline
            : MaterialCommunityIcons.heart,color:  controller.isAddedToWhishlist ? AppColors.error : AppColors.neutralGray),
        label: Text(
          LocaleKeys.whishlist.tr(),
          style: buttonText.copyWith(color: AppColors.neutralGray),
        ),
      ),
    );
  }

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

  get _view => ControlledWidgetBuilder(
          builder: (BuildContext context, ProductController controller) {
        return StateView(
            controller.isLoading ? EmptyState.LOADING : EmptyState.CONTENT,
            _body);
      });

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
                    onPressed: () {
                      if (controller.product.product != null)
                        controller.search(
                            controller.product.product.category_id.toString());
                    },
                    child: Text(
                      LocaleKeys.seeMore.tr(),
                      style: linkText.copyWith(color: AppColors.accent),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 260,
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
        children: [
          _productDetails,
          _recommended(LocaleKeys.similarProducts.tr()),
          SizedBox(
            height: Dimens.spacingLarge,
          )
        ],
      );
}
