import 'package:coupon_app/app/components/category_button.dart';
import 'package:coupon_app/app/components/search_app_bar.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/explore/explore_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:coupon_app/data/repositories/data_category_respository.dart';
import 'package:coupon_app/domain/entities/models/CategoryType.dart';
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
  ExplorePageState() : super(ExploreController(DataCategoryRepository()));

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: _body,
      );

  get _body => ControlledWidgetBuilder(builder: (BuildContext context,  ExploreController controller){
    return StateView(  controller.isLoading ? EmptyState.LOADING : EmptyState.CONTENT, _sections);
  });

  get _sections => ControlledWidgetBuilder(
          builder: (BuildContext context, ExploreController controller) {
        return ListView(
          shrinkWrap: true,
          children: [
            Container(
              color: AppColors.accent.withAlpha(120),
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacingMedium),
                child: Text(LocaleKeys.tabCoupons.tr(), style: heading5.copyWith(color : AppColors.neutralLight),),
              ),
            ),
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            _categories(false),
            Container(
              color: AppColors.accent.withAlpha(120),
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacingMedium),
                child: Text(LocaleKeys.tabProducts.tr(), style: heading5.copyWith(color : AppColors.neutralLight),),
              ),
            ),
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            _categories(true)
          ],
        );
      });

 Widget _categories(bool isProduct) =>ControlledWidgetBuilder(builder: (BuildContext context, ExploreController controller){
    return GridView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemCount:isProduct?  controller.productsCategory.length :  controller.couponsCategory.length,
      itemBuilder: (BuildContext context, index) {
        var categories = isProduct?  controller.productsCategory :  controller.couponsCategory;
        return  _categoryItem(categories[index]);
      }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5),
    );
  });

  Widget _categoryItem(CategoryType category) => ControlledWidgetBuilder(
        builder: (BuildContext context, ExploreController controller) {
          return CategoryButton(
            category: category,
            chipStyle: false,
            size: 80,
            onClick: () {
              controller.search(category);
            },
          );
        },
      );
}
