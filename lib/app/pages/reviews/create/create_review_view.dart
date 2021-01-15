import 'package:coupon_app/app/components/rating.dart';
import 'package:coupon_app/app/pages/reviews/create/create_review_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateReviewPage extends View {
  @override
  State<StatefulWidget> createState() => CreateReviewPageState();
}

class CreateReviewPageState
    extends ViewState<CreateReviewPage, CreateReviewController> {
  CreateReviewPageState() : super(CreateReviewController());

  @override
  Widget get view => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Feather.chevron_left, color: AppColors.neutralGray),
          ),
          title: Text(
            LocaleKeys.writeReview.tr(args: ["5"]),
            style: heading4.copyWith(color: AppColors.neutralDark),
          ),
          shape: appBarShape,
        ),
        key: globalKey,
        body: _body,
      );

  get _body => ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.writeReviewText.tr(),
                  style: heading5.copyWith(color: AppColors.neutralDark),
                ),
                SizedBox(
                  height: Dimens.spacingNormal,
                ),
                Row(
                  children: [
                    Rating(
                      size: 36,
                    ),
                    Text(
                      "4/5",
                      style: heading5.copyWith(color: AppColors.neutralGray),
                    )
                  ],
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                Text(
                  LocaleKeys.writeYourReview.tr(),
                  style: heading5.copyWith(color: AppColors.neutralDark),
                ),
                SizedBox(
                  height: Dimens.spacingNormal,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.writeYourReviewHint.tr(),
                  ),
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                Text(
                  LocaleKeys.addPhoto.tr(),
                  style: heading5.copyWith(color: AppColors.neutralDark),
                ),
                SizedBox(
                  height: Dimens.spacingNormal,
                ),
                SizedBox(
                    width: 80,
                    height: 80,
                    child: OutlinedButton(
                        onPressed: () {},
                        child: Icon(
                          Feather.plus,
                          color: AppColors.neutralGray,
                        ))),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                SizedBox(
                  width: double.infinity,
                    child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    LocaleKeys.submitReview.tr(),
                    style: buttonText.copyWith(color: Colors.white),
                  ),
                ))
              ],
            ),
          )
        ],
      );
}
