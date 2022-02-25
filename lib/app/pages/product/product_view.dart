import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupon_app/app/components/app_image.dart';
import 'package:coupon_app/app/components/banner_product.dart';
import 'package:coupon_app/app/components/countdown.dart';
import 'package:coupon_app/app/components/price.dart';
import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/product_colors.dart';
import 'package:coupon_app/app/components/product_sizes.dart';
import 'package:coupon_app/app/components/rating_bar.dart';
import 'package:coupon_app/app/components/review.dart';
import 'package:coupon_app/app/components/social_share.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/components/variant_picker.dart';
import 'package:coupon_app/app/pages/product/product_controller.dart';
import 'package:coupon_app/app/pages/searchable_view_state.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:coupon_app/data/repositories/data_product_repository.dart';
import 'package:coupon_app/data/repositories/data_whishlist_repository.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductPage extends View {
  final String productId;
  final String slug;
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  ProductPage({
    this.slug,
    this.productId,
  });

  @override
  State<StatefulWidget> createState() =>
      ProductPageView(productId: this.productId, slug: slug);
}

class ProductPageView
    extends SearchableViewState<ProductPage, ProductController> {
  ProductPageView({String productId, String slug})
      : super(ProductController(DataAuthenticationRepository(),
            DataProductRepository(), DataWhishlistRepository(),
            productId: productId, productSlug: slug));

  @override
  Widget get title => ControlledWidgetBuilder(
          builder: (BuildContext context, ProductController controller) {
        return Text(controller.product != null ? controller.product.name : "",
            style: heading5.copyWith(color: AppColors.primary));
      });

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
            _banners(controller),
            _sliderIndicator(controller),
            _productDescription(controller)
          ],
        );
      });

  _productDescription(ProductController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimens.spacingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pricing(controller),
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
                      product: controller.product.product,
                    )
                  : SizedBox(),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              _elapsedTime(controller),
              SizedBox(
                height: Dimens.spacingLarge,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _whishlistButton(controller),
                      SizedBox(
                        width: Dimens.spacingLarge,
                      ),
                      Visibility(
                        visible: !isNotInStock(controller),
                        child: _addToCartButton(controller),
                      )
                    ],
                  )),
              SizedBox(
                height: Dimens.spacingLarge,
              ),
              SocialShareButtons(
                onShare: () {
                  controller.shareProduct();
                },
              ),
              SizedBox(
                height: Dimens.spacingLarge,
              ),
            ],
          ),
        ),
        _description(controller),
        _map(controller),
         Visibility(
           visible: controller.ratings.length > 0,
           child: Padding(
             padding: EdgeInsets.all(8),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                   child: Text(LocaleKeys.ratings.tr(), style: heading6,),
                 ),
                 _reviews,
               ],
             ),
           ),
         )
        // _addReview
      ],
    );
  }

  SizedBox pricing(ProductController controller) {
    if (controller.product == null) {
      return SizedBox();
    }
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: isNotInStock(controller),
                  child: Text(
                    LocaleKeys.outOfStock.tr(),
                    style: captionNormal2.copyWith(color: AppColors.error),
                  ),
                ),
                controller.product != null
                    ? Price(
                        product: controller.product.product,
                        variantValue: controller.selectedProductVariant,
                      )
                    : SizedBox()
              ],
            ),
          ),
          controller.product != null &&
                  controller.product.product != null &&
                  double.tryParse(controller.product.product
                          .getDiscount(controller.selectedProductVariant)) >
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
                        padding: const EdgeInsets.only(right: 0, left: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                "${controller.product.product.getDiscount(controller.selectedProductVariant)}%\n${LocaleKeys.off.tr()}",
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
    );
  }

  bool isNotInStock(ProductController controller) {
    return controller.product != null &&
                    controller.product.product != null &&
        (controller.product.product.stock <= 0 ||
            (controller.selectedProductVariant != null && controller.selectedProductVariant.stock <= 0));
  }

  Widget _elapsedTime(ProductController controller) {
    return Visibility(
      visible:
          controller.product != null && controller.product.product.isInOffer(),
      child: Row(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.timeLeft.tr(),
                style: bodyTextMedium1.copyWith(
                  color: AppColors.primary,
                ),
              ),
              CountdownView(
                showIcon: false,
                textStyle: heading5.copyWith(color: AppColors.accent),
                isValidTime: (isValid) {
                  controller.isValidTime(isValid);
                },
                validTo: DateHelper.parseServerDateTime(
                    controller.product.product.offer_to),
                validFrom: DateHelper.parseServerDateTime(
                    controller.product.product.offer_from),
              )
            ],
          )
        ],
      ),
    );
    return controller.product.product.valid_from != null &&
            controller.product.product.valid_to != null
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              controller.product != null &&
                      controller.product.product.isInOffer()
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.timeLeft.tr(),
                              style: bodyTextMedium1.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            CountdownView(
                              showIcon: false,
                              textStyle:
                                  heading5.copyWith(color: AppColors.accent),
                              isValidTime: (isValid) {
                                controller.isValidTime(isValid);
                              },
                              validTo: DateHelper.parseServerDateTime(
                                  controller.product.product.offer_to),
                              validFrom: DateHelper.parseServerDateTime(
                                  controller.product.product.offer_from),
                            )
                          ],
                        )
                      ],
                    )
                  : SizedBox(),
            ],
          )
        : SizedBox();
  }

  _addToCartButton(ProductController controller) {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: RaisedButton.icon(
              onPressed: () {
                controller.addToCartWithVariant(controller.product.product,
                    controller.selectedProductVariant);
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
          ),
          Visibility(
            visible: controller.product != null &&
                controller.product.product != null &&
                controller.product.product.maxQty > 0,
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Text(LocaleKeys.maxQty
                    .tr(args: [controller.product.product.maxQty.toString()])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _whishlistButton(ProductController controller) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () {
          controller.addItemToWhishlist(controller.product.product);
          widget.analytics.logAddToWishlist(
            currency: 'KD',
            value: double.tryParse(controller.product.product
                .getVariantOfferPriceByVariant(
                    controller.selectedProductVariant)),
            items: [
              AnalyticsEventItem(
                  itemId: controller.product.product.id.toString(),
                  itemName: controller.product.name,
                  itemCategory:
                      controller.product.product.category_id.toString(),
                  quantity: 1,
                  price: double.tryParse(controller.product.product
                      .getVariantOfferPriceByVariant(
                          controller.selectedProductVariant)))
            ],
          );
        },
        icon: Icon(
            !controller.isAddedToWhishlist
                ? MaterialCommunityIcons.heart_outline
                : MaterialCommunityIcons.heart,
            color: controller.isAddedToWhishlist
                ? AppColors.error
                : AppColors.neutralGray),
        label: Text(
          LocaleKeys.whishlist.tr(),
          style: buttonText.copyWith(color: AppColors.neutralGray),
        ),
      ),
    );
  }

   get _reviews => ControlledWidgetBuilder(
        builder: (BuildContext context, ProductController controller) {
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(8),
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.ratings != null ? controller.ratings.length  : 0,
            itemBuilder: (BuildContext context, int index) {
              var rating  = controller.ratings[index];
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                rating != null && rating.rating != null ?  RatingBar(size: 20,initialRating: rating.rating,) : SizedBox()
                              ],
                            ),
                          ),
                          Text(rating.rating != null && rating.created != null ? DateHelper
                              .formatServerDate(rating.created) : "",
                            style: captionNormal2.copyWith(color: AppColors.neutralGray),)
                        ],
                      ),
                      SizedBox(
                        height: Dimens.spacingNormal,
                      ),
                      Text(rating.review, style: bodyTextNormal2.copyWith(color: AppColors.neutralDark),),
                    ],
                  ),
                ),
              );
            },
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
        return controller.similarProducts != null &&
                controller.similarProducts.length > 0
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.spacingMedium),
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
                              controller.search(controller
                                  .product.product.category.id
                                  .toString());
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
                    height: MediaQuery.of(context).size.width * 0.75,
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
              )
            : SizedBox();
      });

  get _body => ListView(
        shrinkWrap: true,
        children: [
          _productDetails,
          _recommended(LocaleKeys.similarProducts.tr()),
          SizedBox(
            height: Dimens.spacingLarge,
          )
        ],
      );

  _banners(ProductController controller) {
    if (controller.selectedProductVariant != null) {
      return SizedBox(
          height: MediaQuery.of(context).size.width,
          child: AppImage(controller.selectedProductVariant.image));
    }
    return controller.product != null &&
            controller.product.product != null &&
            controller.product.product.product_gallery != null &&
            controller.product.product.product_gallery.length > 0
        ? CarouselSlider.builder(
            itemCount: controller.product.product.product_gallery.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              var gallery = controller.product.product.product_gallery ?? [];
              return InkWell(
                  onTap: () {
                    controller.openImage(gallery[index].image);
                  },
                  child: AppImage(gallery[index].image));
            },
            options: CarouselOptions(
              height: MediaQuery.of(context).size.width,
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
        : controller.product != null && controller.product.product != null
            ? SizedBox(
                height: MediaQuery.of(context).size.width,
                child: AppImage(controller.product.product.thumb_img))
            : SizedBox();
  }

  _sliderIndicator(ProductController controller) {
    return Visibility(
      visible: controller.selectedProductVariant == null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            controller.product != null &&
                    controller.product.product != null &&
                    controller.product.product.product_gallery != null &&
                    controller.product.product.product_gallery.length > 0
                ? AnimatedSmoothIndicator(
                    activeIndex: sliderImageIndex,
                    count: controller.product.product.product_gallery.length,
                    effect: WormEffect(dotWidth: 8, dotHeight: 8),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  _description(ProductController controller) {
    return Container(
      color: AppColors.expandableBackground,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: controller.product != null &&
                  controller.product.product != null &&
                  !controller.product.product.category_type,
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  initiallyExpanded: true,
                  title: Text(
                    LocaleKeys.details.tr(),
                    style: heading5.copyWith(color: AppColors.neutralDark),
                  ),
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              LocaleKeys.validity.tr() + " : ",
                              style: heading6,
                            ),
                            Text(
                              controller.product.product.valid_from != null &&
                                      controller.product.product.valid_to !=
                                          null
                                  ? DateHelper.formatServerDateOnly(controller
                                          .product.product.valid_from) +
                                      " - ${DateHelper.formatServerDateOnly(controller.product.product.valid_to)}"
                                  : "",
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              LocaleKeys.valueOfCoupon.tr() + " : ",
                              style: heading6,
                            ),
                            Text(
                              Utility.currencyFormat(
                                  controller.product.product.price),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              LocaleKeys.location.tr() + " : ",
                              style: heading6,
                            ),
                            Text(controller.product.product.seller.address)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(
                  LocaleKeys.deals.tr(),
                  style: heading5.copyWith(color: AppColors.neutralDark),
                ),
                children: [
                  Html(
                    data: controller.product != null
                        ? controller.product.full_description
                        : "",
                    shrinkWrap: false,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: controller.product != null &&
                  controller.product.in_box != null,
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Text(
                    LocaleKeys.inBox.tr(),
                    style: heading5.copyWith(color: AppColors.neutralDark),
                  ),
                  expandedAlignment: Alignment.topLeft,
                  children: [
                    Html(
                      data: controller.product != null &&
                              controller.product.in_box != null
                          ? controller.product.in_box
                          : "",
                      shrinkWrap: false,
                    ),
                    SizedBox(
                      height: Dimens.spacingMedium,
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: controller.product != null &&
                  controller.product.warranty != null,
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Text(
                    LocaleKeys.warranty.tr(),
                    style: heading5.copyWith(color: AppColors.neutralDark),
                  ),
                  expandedAlignment: Alignment.topLeft,
                  children: [
                    Html(
                      data: controller.product != null &&
                              controller.product.warranty != null
                          ? controller.product.warranty
                          : "",
                      shrinkWrap: false,
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: controller.product != null &&
                  controller.product.notes != null,
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Text(
                    controller.product.product.category_type
                        ? LocaleKeys.features.tr()
                        : LocaleKeys.notes.tr(),
                    style: heading5.copyWith(color: AppColors.neutralDark),
                  ),
                  expandedAlignment: Alignment.topLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Html(
                        data: controller.product != null &&
                                controller.product.notes != null
                            ? controller.product.notes
                                .replaceAll("\\\n", "<br>")
                            : "",
                        shrinkWrap: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _map(ProductController controller) {
    if (!controller.canShowLocation()) {
      return SizedBox();
    }
    if (controller.cameraPosition == null) {
      return SizedBox();
    }
    return AppGoogleMap(
      markers: controller.markers,
      cameraPosition: controller.cameraPosition,
      mapController: controller.mapController,
    );
  }
}

class AppGoogleMap extends StatelessWidget {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  CameraPosition cameraPosition;
  Completer<GoogleMapController> mapController = Completer();

  AppGoogleMap({Key key, this.markers, this.cameraPosition, this.mapController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.h,
      child: GoogleMap(
        markers: Set<Marker>.of(markers.values),
        mapType: MapType.normal,
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController mapController) {
          this.mapController.complete(mapController);
        },
      ),
    );
  }
}
