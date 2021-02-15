import 'package:coupon_app/app/components/banner_product.dart';
import 'package:coupon_app/app/components/custom_app_bar.dart';
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
class Product{
  final String title;
  final String url;
  final String description;
  final String fullDescription;
  final double price;
  final String timeLeft;

  Product({this.title, this.url, this.description, this.fullDescription, this.price, this.timeLeft});
}
class ProductPageView extends ViewState<ProductPage, ProductController> {
  ProductPageView() : super(ProductController());

  final Product product = Product(
    title:"Save 57% and Enjoy 1 Night stay in a Diplomatic Suite with a Private Pool including Lunch + Breakfast for 2 Persons at The Convention Center & Royal Suites Hotel– Free Zone",
    description: "Get KD207 Value Service for only KD90",
    fullDescription: "Surprise your beloved one with an unforgettable Romantic Night in a diplomatic suite with a private warm swimming pool including breakfast & lunch at The Convention Center & Royal Suites Hotel– Free Zone.",
    url: "https://sheeelcdn.cachefly.net/media/catalog/product/cache/1/image/800x800/4d3ec06b4f2a04ed8140a36497b86d9b/d/e/deluxe-room-3_5_1_2.jpg",
    price: 8,
    timeLeft: "101h: 46m: 12s"
  );

  @override
  Widget get view => Scaffold(
        key: globalKey,
    appBar: customAppBar(
        title: Text(
          "Yummy Cakes Coupon",
          style: heading5.copyWith(color: AppColors.primary),
        )),
        body: _body,
      );

  get _productDetails => ListView(
        shrinkWrap: true,
        children: [
          Image.network(
            product.url,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You save 44 %",
                  style: heading5.copyWith(color: AppColors.accent),
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                Text(
                  product.title,
                  style: heading3.copyWith(color: AppColors.primary),
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                Text(
                  product.description,
                  style: heading4.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                Text(
                  product.fullDescription,
                  style: bodyTextMedium2.copyWith(
                      color: AppColors.neutralGray,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                Text(
                  "Colors",
                  style: heading4.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                ProductColors(),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                          style: heading4,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text("Buy Now", style: buttonText,),
                    ))
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
