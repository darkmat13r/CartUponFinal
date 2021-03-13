import 'package:coupon_app/app/components/coupon_item.dart';
import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/components/search_app_bar.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/search/search_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/repositories/coupon/data_coupon_repository.dart';
import 'package:coupon_app/domain/entities/coupons/category_detail_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SearchPage extends View {
  CategoryDetailEntity couponCategory;

  SearchPage({this.couponCategory});

  @override
  State<StatefulWidget> createState() => SearchPageState(couponCategory);
}

class SearchPageState extends ViewState<SearchPage, SearchController> {
  SearchPageState(CategoryDetailEntity couponCategory)
      : super(SearchController(DataCouponRepository(),
            couponCategory: couponCategory));

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: _body,
        appBar: customAppBar(
            title: Text(
          widget.couponCategory != null ? widget.couponCategory.name : "",
          style: heading5.copyWith(color: AppColors.primary),
        )),
      );

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext context, SearchController controller) {
        double cardWidth = MediaQuery.of(context).size.width / 3.3;
        double cardHeight = 170;
        return StateView(
            controller.isLoading
                ? EmptyState.LOADING
                : controller.coupons == null || controller.coupons.length == 0
                    ? EmptyState.EMPTY
                    : EmptyState.CONTENT,
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimens.spacingMedium),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          LocaleKeys.fmtSearchResult.tr(args: [
                            controller.coupons != null
                                ? controller.coupons.length.toString()
                                : 0.toString()
                          ]),
                          style: bodyTextNormal1.copyWith(
                              color: AppColors.neutralGray),
                        ),
                      ),
                      Text(
                        widget.couponCategory != null
                            ? widget.couponCategory.name
                            : "",
                        style: bodyTextNormal1.copyWith(
                            color: AppColors.neutralDark),
                      ),
                      _filterButton
                    ],
                  ),
                ),
                GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.coupons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: cardWidth / cardHeight,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return CouponItem(
                          coupon: controller.coupons[index],
                          onClickItem: () {},
                      onAddToCart: (){
                            controller.addToCart(controller.coupons[index]);
                      },);
                    })
              ],
            ));
      });

  get _filterButton => ControlledWidgetBuilder(
          builder: (BuildContext context, SearchController controller) {
        return InkWell(
          onTap: () {
            controller.filter();
          },
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              Feather.chevron_down,
              color: AppColors.neutralGray,
            ),
          ),
        );
      });
}
