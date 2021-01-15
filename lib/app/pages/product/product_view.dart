import 'package:coupon_app/app/components/product_colors.dart';
import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/components/product_sizes.dart';
import 'package:coupon_app/app/components/rating.dart';
import 'package:coupon_app/app/components/review.dart';
import 'package:coupon_app/app/pages/product/product_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductPage extends View {
  @override
  State<StatefulWidget> createState() => ProductPageView();
}

class ProductPageView extends ViewState<ProductPage, ProductController> {
  ProductPageView() : super(ProductController());

  @override
  Widget get view => Scaffold(
        key: globalKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Feather.chevron_left, color: AppColors.neutralGray),
            onPressed: () {},
          ),
          title: Text(
            "Nike Air Max 270 Rea...",
            style: heading4.copyWith(color: AppColors.neutralDark),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Feather.search,
                  color: AppColors.neutralGray,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(Feather.more_vertical, color: AppColors.neutralGray),
                onPressed: () {}),
          ],
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: AppColors.neutralLight, width: Dimens.borderWidth)),
        ),
        body: _body,
      );

  get _productDetails => ListView(
        shrinkWrap: true,
        children: [
          Container(
              width: double.infinity,
              height: 240,
              decoration: const BoxDecoration(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(Dimens.cornerRadius)),
                  color: AppColors.neutralLight),
              child: Image(
                width: double.infinity,
                image: AssetImage(Resources.shoe),
              )),
          SizedBox(
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text("Nike Air Zoom Pegasus 36 Miami",
                          style:
                              heading4.copyWith(color: AppColors.neutralDark)),
                    ),
                    IconButton(
                      icon: Icon(
                        Feather.heart,
                        color: AppColors.neutralGray,
                      ),
                      onPressed: () {

                      },
                    )
                  ],
                ),
                Rating(
                  size: 20,
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                Text(
                  "\$299,43",
                  style: heading3.copyWith(color: AppColors.primary),
                ),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                Text(
                  LocaleKeys.selectSize.tr(),
                  style: heading5.copyWith(color: AppColors.neutralDark),
                ),
                SizedBox(
                  height: Dimens.spacingNormal,
                ),
                ProductSizes(),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                Text(
                  LocaleKeys.selectColor.tr(),
                  style: heading5.copyWith(color: AppColors.neutralDark),
                ),
                SizedBox(
                  height: Dimens.spacingNormal,
                ),
                ProductColors(),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                Text(
                  LocaleKeys.specification.tr(),
                  style: heading5.copyWith(color: AppColors.neutralDark),
                ),
                SizedBox(
                  height: Dimens.spacingNormal,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.shown.tr() + ":",
                      style: bodyTextNormal2.copyWith(
                          color: AppColors.neutralDark),
                    ),
                    Expanded(child: SizedBox()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Laser",
                            style: bodyTextNormal2.copyWith(
                                color: AppColors.neutralGray)),
                        Text("Blue/Anthracite/Watermel",
                            style: bodyTextNormal2.copyWith(
                                color: AppColors.neutralGray)),
                        Text("on/White",
                            style: bodyTextNormal2.copyWith(
                                color: AppColors.neutralGray)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.style.tr() + ":",
                      style: bodyTextNormal2.copyWith(
                          color: AppColors.neutralDark),
                    ),
                    Expanded(child: SizedBox()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("CD0113-400",
                            style: bodyTextNormal2.copyWith(
                                color: AppColors.neutralGray)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                Text(
                    "The Nike Air Max 270 React ENG combines a full-length React foam midsole with a 270 Max Air unit for unrivaled comfort and a striking visual experience.",
                    style:
                        bodyTextNormal2.copyWith(color: AppColors.neutralGray)),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                _reviews,
                _recommended(LocaleKeys.youMayLike.tr())
              ],
            ),
          ),
          SizedBox(
            height: 70,
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

  Widget _recommended(String name) => Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                name,
                style: heading5.copyWith(color: AppColors.neutralDark),
              )),
              TextButton(
                onPressed: () {},
                child: Text(
                  LocaleKeys.seeMore.tr(),
                  style: linkText,
                ),
              )
            ],
          ),
          Container(
            height: 300,
            width: double.infinity,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
              ],
            ),
          )
        ],
      );

  _createProductItem() {
    return SizedBox(width: 200, child: ProductItem(() => {}));
  }

  get _body => Stack(
        children: [
          _productDetails,
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimens.spacingMedium,
                    horizontal: Dimens.spacingMedium),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(LocaleKeys.addToCart.tr(), style: buttonText),
                ),
              ),
            ),
          )
        ],
      );
}
