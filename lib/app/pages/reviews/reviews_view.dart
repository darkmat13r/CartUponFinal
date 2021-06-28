import 'package:coupon_app/app/components/review.dart';
import 'package:coupon_app/app/pages/reviews/reviews_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ReviewsPage extends View {
  @override
  State<StatefulWidget> createState() => ReviewsPageState();
}

class ReviewsPageState extends ViewState<ReviewsPage, ReviewsController> {
  ReviewsPageState() : super(ReviewsController());

  @override
  Widget get view => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: () {

          }, icon: Icon(Feather.chevron_left,  color: AppColors.neutralGray),
          ),
          title: Text(
            LocaleKeys.reviews.tr(args: ["5"]),
            style: heading4.copyWith(color: AppColors.neutralDark),
          ),
          shape: appBarShape,
        ),
        key: globalKey,
        body: _body,
      );

  get _body => Padding(
    padding: const EdgeInsets.all(Dimens.spacingMedium),
    child: Stack(
      children: [
        ListView(
          shrinkWrap: false,
              children: [
                _reviewFilter,
                SizedBox(height: Dimens.spacingLarge,),
                //ReviewItem(),
                SizedBox(height: Dimens.spacingLarge,),
               // ReviewItem(),
                SizedBox(height: Dimens.spacingLarge,),
                //ReviewItem(),
                SizedBox(height: Dimens.spacingLarge,),
              //  ReviewItem(),
                SizedBox(height: Dimens.spacingLarge,),
                SizedBox(height: Dimens.spacingLarge,),
                SizedBox(height: Dimens.spacingLarge,),
              ],
            ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _createReviewButton,
        ),

      ],
    ),
  );

  get _reviewFilter => Container(
        height: 48,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: false,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,Dimens.spacingNormal, 0),
              child: FlatButton(
                  color: AppColors.primary.withAlpha(10),
                  onPressed: () {},
                  child: Text(
                    LocaleKeys.allReviews.tr(),
                    style: buttonText.copyWith(color: AppColors.primary),
                  )),
            ),
            _ratingFilterItem("1"),
            _ratingFilterItem("2"),
            _ratingFilterItem("3"),
            _ratingFilterItem("4"),
            _ratingFilterItem("5"),
          ],
        ),
      );

  get _createReviewButton => ControlledWidgetBuilder(builder: (BuildContext context, ReviewsController controller) {
    return RaisedButton(onPressed: (){
      controller.createReview();
    }, child: Text(
    LocaleKeys.writeReview.tr(),
    style: buttonText.copyWith(color: Colors.white),
    ));
  },);

  Widget _ratingFilterItem(number) => Padding(
        padding: const EdgeInsets.fromLTRB(0,0,Dimens.spacingNormal, 0),
        child: OutlinedButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  Octicons.star,
                  color: AppColors.yellow,
                  size: 14,
                ),
                Text(
                  number,
                  style: buttonText.copyWith(color: AppColors.primary),
                ),
              ],
            )),
      );
}
