import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupon_app/app/components/app_image.dart';
import 'package:coupon_app/app/components/banner_product.dart';
import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/components/product_colors.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/home/listing/main_listing_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/repositories/banner/data_slider_repository.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:coupon_app/data/repositories/data_home_repository.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/Section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MainListingPage extends View {
  @override
  State<StatefulWidget> createState() => _MainListingState();
}

class _MainListingState extends ViewState<MainListingPage, MainListingController> {
  _MainListingState() : super(
      MainListingController(DataHomeRepository(), DataAuthenticationRepository()));

  @override
  Widget get view =>
      Scaffold(
          key: globalKey,
          body: _body);

  get _body =>
      ControlledWidgetBuilder(
          builder: (BuildContext context, MainListingController controller) {
            return StateView(
              controller.isLoading ? EmptyState.LOADING : EmptyState.CONTENT,
              ListView(
                shrinkWrap: true,
                children: [
                  _sliders,
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  _adBanners,
                  _featuredProducts(controller),//TODO Banner Products
                  SizedBox(
                    height: Dimens.spacingNormal,
                  ),
                  _sections
                ],
              ),
            );
          });

  get _sections =>
      ControlledWidgetBuilder(
          builder: (BuildContext context, MainListingController controller) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var sectionItem = controller.homeResponse.sections[index];
                return _sectionItem(
                    sectionItem
                );
              }, shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.homeResponse != null &&
                  controller.homeResponse.sections != null ? controller
                  .homeResponse.sections.length : 0,);
          });

  get _sliders =>
      ControlledWidgetBuilder(
          builder: (BuildContext context, MainListingController controller) {
            return controller.homeResponse != null &&
                controller.homeResponse.sliders != null &&
                controller.homeResponse.sliders.length > 0 ? CarouselSlider
                .builder(
                itemCount: controller.homeResponse.sliders.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  var slider =  controller.homeResponse.sliders[index];
                  var bannerUrl = slider
                      .mobile_banner;
                  return InkWell(
                    onTap: (){
                      controller.onClickSlider(slider);
                    },
                      child: AppImage(bannerUrl, fit: BoxFit.cover,));
                },
                options: CarouselOptions(
                  height: 240,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  scrollDirection: Axis.horizontal,
                )) : SizedBox();
          });

  get _loginCard =>
      ControlledWidgetBuilder(
          builder: (BuildContext context, MainListingController controller) {
            return controller.currentUser == null ? Padding(
              padding: const EdgeInsets.all(Dimens.spacingSmall),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: Dimens.spacingMedium,
                      right: Dimens.spacingMedium,
                      top: Dimens.spacingSmall),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.completePurchaseFaster.tr(),
                        style: heading6,
                      ),
                      Text(
                        LocaleKeys.messageSignIn.tr(),
                        style:
                        captionNormal1.copyWith(color: AppColors.neutralGray),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              controller.login();
                            },
                            child: Text(
                              LocaleKeys.signIn.tr(),
                              style: buttonText.copyWith(color: AppColors
                                  .accent, fontSize: 12),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.register();
                            },
                            child: Text(
                              LocaleKeys.signUp.tr(),
                              style: buttonText.copyWith(color: AppColors
                                  .accent, fontSize: 12),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ) : SizedBox();
          });

  get _adBanners =>
      ControlledWidgetBuilder(
          builder: (BuildContext context, MainListingController controller) {
            return controller.homeResponse != null &&
                controller.homeResponse.adbanners != null &&
                controller.homeResponse.adbanners.length > 0 ? CarouselSlider
                .builder(
                itemCount: controller.homeResponse.adbanners.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  var adBanner = controller.homeResponse.adbanners[index];
                  var bannerUrl =
                      adBanner.mobile_banner;
                  return InkWell(
                    onTap: (){
                      controller.onClickBanner(adBanner);
                    },
                      child: AppImage(bannerUrl,fit : BoxFit.cover));
                },
                options: CarouselOptions(
                  height: 90,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 10),
                  scrollDirection: Axis.horizontal,
                )) : SizedBox();
          });

  Widget _sectionItem(Section section) =>
      ControlledWidgetBuilder(
          builder: (BuildContext context, MainListingController controller) {
            return Column(
              children: [
                SizedBox(height: Dimens.spacingMedium,),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                            section.name,
                            maxLines: 2,
                            style: heading5.copyWith(color: AppColors.primary),
                          )),
                      TextButton(
                        onPressed: () {
                          controller.search(section.category.id.toString());
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
                  height: 310.sp,
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: section.category != null &&
                        section.category.products != null ? section.category
                        .products.length : 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: Dimens.productCardWidth,
                        child: ProductItem(
                          product: section.category.products[index],
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          });

  _featuredProducts(MainListingController controller) {
    return Visibility(
      visible: controller.homeResponse != null &&  controller.homeResponse.featured_products != null  ? controller.homeResponse.featured_products.length > 0 : false,
      child: Column(
        children: [
          SizedBox(height: Dimens.spacingMedium,),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                      LocaleKeys.dealsAndOutlet.tr(),
                      maxLines: 2,
                      style: heading5.copyWith(color: AppColors.primary),
                    )),

              ],
            ),
          ),
          Container(
            height: 310.sp,
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.homeResponse != null && controller.homeResponse.featured_products != null ? controller.homeResponse.featured_products.length :0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: Dimens.productCardWidth,
                  child: ProductItem(
                    product: controller.homeResponse.featured_products[index],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
