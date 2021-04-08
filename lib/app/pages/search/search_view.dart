import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/search_app_bar.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/search/search_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/repositories/data_category_respository.dart';
import 'package:coupon_app/data/repositories/data_product_repository.dart';
import 'package:coupon_app/domain/entities/models/CategoryType.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SearchPage extends View {
  CategoryType category;
  String  categoryId;

  SearchPage({this.category, this.categoryId});

  @override
  State<StatefulWidget> createState() => SearchPageState(categoryType : category,categoryId: categoryId);
}

class SearchPageState extends ViewState<SearchPage, SearchController> {
  SearchPageState({CategoryType categoryType, String categoryId})
      : super(SearchController(DataProductRepository(), DataCategoryRepository(),
      categoryType: categoryType, categoryId : categoryId));

  @override
  Widget get view => ControlledWidgetBuilder(builder: (BuildContext context, SearchController controller){
    return Scaffold(
      key: globalKey,
      body: _body,
      appBar: customAppBar(
          title: Text(
            controller.categoryType != null ? controller.categoryType.name : "",
            style: heading5.copyWith(color: AppColors.primary),
          )),
    );
  });

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext context, SearchController controller) {
        double cardWidth = MediaQuery.of(context).size.width / 3.3;
        double cardHeight = 156;
        return StateView(
            controller.isLoading
                ? EmptyState.LOADING
                : controller.products == null || controller.products.length == 0
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
                            controller.products != null
                                ? controller.products.length.toString()
                                : 0.toString()
                          ]),
                          style: bodyTextNormal1.copyWith(
                              color: AppColors.neutralGray),
                        ),
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
                      crossAxisCount: 2,
                      childAspectRatio: cardWidth / cardHeight,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ProductItem(
                          product: controller.products[index],);
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
              Feather.filter,
              color: AppColors.neutralGray,
            ),
          ),
        );
      });
}
