import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:easy_localization/easy_localization.dart';
class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
          border: Border.fromBorderSide(
              BorderSide(color: AppColors.neutralLight))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimens.spacingMedium, 0, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Ink(
              decoration: const ShapeDecoration(shape: CircleBorder()),
              child: IconButton(
                icon: Icon(MaterialCommunityIcons.cart),
                color: AppColors.neutralGray,
                onPressed: () {},
              ),
            ),
            Ink(
              decoration: const ShapeDecoration(shape: CircleBorder()),
              child: IconButton(
                icon: Icon(MaterialCommunityIcons.search_web),
                color: AppColors.neutralGray,
                onPressed: () {},
              ),
            ),

          ],
        ),
      ),
    );
  }
}
