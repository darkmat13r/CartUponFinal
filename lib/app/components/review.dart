import 'package:coupon_app/app/components/rating_bar.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/domain/entities/models/Rating.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewItem extends StatefulWidget {
  final Rating rating;
  final Customer token;

  ReviewItem(this.rating, {this.token});

  @override
  State<StatefulWidget> createState() => ReviewState();

}

class ReviewState extends State<ReviewItem> {

  get _reviewText =>
      widget.rating != null && widget.rating.review != null &&
          widget.rating.review.length > 0 ? widget.rating.review : LocaleKeys
          .noReviewText.tr();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*CircleAvatar(
              radius: 25,
              child: Image.asset(Resources.shoe),
            ),
            SizedBox(
              width: Dimens.spacingMedium,
            ),*/
           Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widget.token != null ?  Text(widget.token.user.first_name,
                  style: heading5.copyWith(color: AppColors.neutralDark),): SizedBox(),
                widget.rating != null && widget.rating.rating != null ?  RatingBar(size: 20,initialRating: widget.rating.rating,) : SizedBox()
              ],
            )
          ],
        ),
        SizedBox(
          height: Dimens.spacingNormal,
        ),
        Text(_reviewText, style: bodyTextNormal2,),
        SizedBox(
          height: Dimens.spacingMedium,
        ),
       /* Row(
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
        ),*/
        SizedBox(
          height: Dimens.spacingNormal,
        ),
        Text(widget.rating != null && widget.rating.created != null ? DateHelper
            .formatServerDate(widget.rating.created) : "",
          style: captionNormal2.copyWith(color: AppColors.neutralGray),)
      ],
    );
  }

}