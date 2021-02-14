import 'package:coupon_app/app/components/product_colors.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BannerProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BannerProductState();
}

class _BannerProductState extends State<BannerProduct> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              "https://sheeelcdn.cachefly.net/media/catalog/product/cache/1/image/800x800/4d3ec06b4f2a04ed8140a36497b86d9b/u/m/umdipb922qa-en.jpg",
              fit: BoxFit.cover,
            ),
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
                  "Powerey 10000mAh Power Bank with Built-in Cable ",
                  style: heading3.copyWith(color: AppColors.neutralDark),
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                Text(
                  "Built-in Lightning, Type-C, and also Micro-USB cable",
                  style: heading4.copyWith(
                      color: AppColors.neutralDark,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                Text(
                  "A power bank with sufficient capacity always comes in handy for charging mobile handheld devices. One such is the Powerey brand, whose model is equipped with a battery with a capacity of 10,000mAh",
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
                            style: heading4.copyWith(
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
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                color: AppColors.neutralLightGray,
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.spacingMedium),
                  child: Center(
                    child: Text(
                      "More about this deal",
                      style: buttonText.copyWith(color: AppColors.primary),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );


}