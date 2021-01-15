import 'package:coupon_app/app/components/search_app_bar.dart';
import 'package:coupon_app/app/pages/explore/explore_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ExplorePage extends View {
  @override
  State<StatefulWidget> createState() => ExplorePageState();
}

class ExplorePageState extends ViewState<ExplorePage, ExploreController> {
  ExplorePageState() : super(ExploreController());

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: _body,
      );

  get _body => ListView(
        shrinkWrap: true,
        children: [
          SearchAppBar(),
          Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: Text(
              "Coupons",
              style: heading5.copyWith(color: AppColors.neutralDark),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(8),
            children: List.generate(
                9, (index) => _categoryItem(Feather.tag, "Coupons")),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: Text(
              "Electronics",
              style: heading5.copyWith(color: AppColors.neutralDark),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(8),
            children: List.generate(
                9, (index) => _categoryItem(Feather.smartphone, "Mobile")),
          )
        ],
      );

  Widget _categoryItem(icon, name) => ControlledWidgetBuilder(builder: (BuildContext context, ExploreController controller) {
    return InkWell(
      onTap: (){
        controller.search();
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(36)),
                border: Border.all(
                    color: AppColors.neutralLight,
                    width: Dimens.borderWidth)),
            child: Padding(
              padding: const EdgeInsets.all(Dimens.spacingMedium),
              child: Icon(
                icon,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(
            height: Dimens.spacingNormal,
          ),
          Text(name)
        ],
      ),
    );
  },);
}
