import 'package:coupon_app/app/components/rating.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewItem extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ReviewState();

}

class ReviewState extends State<ReviewItem>{
  final String demoReview = "air max are always very comfortable fit, clean and just perfect in every way. just the box was too small and scrunched the sneakers up a little bit, not sure if the box was always this small but the 90s are and will always be one of my favorites.";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              child: Image.asset(Resources.shoe),
            ),
            SizedBox(
              width: Dimens.spacingMedium,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("James Lawson", style: heading5.copyWith(color: AppColors.neutralDark),),
                Rating(size: 20,)
              ],
            )
          ],
        ),
        SizedBox(
          height: Dimens.spacingNormal,
        ),
        Text(demoReview, style: bodyTextNormal2,),
        SizedBox(
          height: Dimens.spacingMedium,
        ),
        Row(
          children: [
            Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(16)),
                    color: AppColors.neutralLight),
                child: Image(
                  width: double.infinity,
                  image: AssetImage(Resources.shoe),
                )),
            SizedBox(
              width: Dimens.spacingNormal,
            ),
            Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(16)),
                    color: AppColors.neutralLight),
                child: Image(
                  width: double.infinity,
                  image: AssetImage(Resources.shoe),
                )),
            SizedBox(
              width: Dimens.spacingNormal,
            ),
            Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(16)),
                    color: AppColors.neutralLight),
                child: Image(
                  width: double.infinity,
                  image: AssetImage(Resources.shoe),
                )),
          ],
        ),
        SizedBox(
          height: Dimens.spacingNormal,
        ),
        Text("December 10, 2016", style: captionNormal2.copyWith(color: AppColors.neutralGray),)
      ],
    );
  }

}