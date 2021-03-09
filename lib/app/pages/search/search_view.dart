import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/components/search_app_bar.dart';
import 'package:coupon_app/app/pages/search/search_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SearchPage extends View {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends ViewState<SearchPage, SearchController> {
  SearchPageState() : super(SearchController());

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: _body,
        appBar: customAppBar(
            title: Text(
          "Yummy Cakes..",
          style: heading5.copyWith(color: AppColors.primary),
        )),
      );

  get _body => ControlledWidgetBuilder(builder: (BuildContext context, SearchController controller){
    double cardWidth = MediaQuery
        .of(context)
        .size
        .width / 3.3;
    double cardHeight = 170;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimens.spacingMedium),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "148 Result",
                  style:
                  bodyTextNormal1.copyWith(color: AppColors.neutralGray),
                ),
              ),
              Text(
                "Electronics Coupons",
                style: bodyTextNormal1.copyWith(color: AppColors.neutralDark),
              ),
              _filterButton
            ],
          ),
        ),
        GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: cardWidth / cardHeight,),
            itemBuilder: (BuildContext context, int index) {
              return ProductItem(product: controller.products[index], onClickItem: (){});
            })
      ],
    );
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
