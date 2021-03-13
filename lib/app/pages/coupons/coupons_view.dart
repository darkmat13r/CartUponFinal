import 'package:coupon_app/app/components/banner_product.dart';
import 'package:coupon_app/app/components/category_button.dart';
import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/pages/coupons/coupons_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/data/repositories/coupon/data_coupon_category_respository.dart';
import 'package:coupon_app/domain/entities/category_entity.dart';
import 'package:coupon_app/domain/entities/coupons/category_detail_entity.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CouponsPage extends View {
  @override
  State<StatefulWidget> createState() => CouponsPageState();
}

class CouponsPageState extends ViewState<CouponsPage, CouponsController> {
  CouponsPageState() : super(CouponsController(DataCouponCategoryRepository()));

  @override
  Widget get view =>
      Scaffold(
        key: globalKey,
        body: ListView(
          shrinkWrap: true,
          children: [
            _categories,
            BannerProduct(),
            SizedBox(
              height: Dimens.spacingLarge,
            ),
            _recommendedItems()
          ],
        ),
      );

  get _categories =>
      ControlledWidgetBuilder(
          builder: (BuildContext context, CouponsController controller) {
            return SizedBox(
              height: 120,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  itemBuilder: (BuildContext context, index) {
                    return _categoryItem(controller.categories[index]);
                  }),
            );
          });

  Widget _categoryItem(CategoryDetailEntity category) =>
      ControlledWidgetBuilder(
        builder: (BuildContext context, CouponsController controller) {
          return CategoryButton(
            category: category,
            onClick: () {
              controller.search(category);
            },
          );
        },
      );

  Widget _recommendedItems() {
    double cardWidth = MediaQuery
        .of(context)
        .size
        .width / 3.3;
    double cardHeight = MediaQuery
        .of(context)
        .size
        .height / 4.32;
    return ControlledWidgetBuilder(builder: (BuildContext context, CouponsController controller){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "More Super Coupons",
              style: heading4.copyWith(color: AppColors.primary),
            ),
          ),
          GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: cardWidth / cardHeight,),
              itemBuilder: (BuildContext context, int index) {
                return _createProductItem(controller.products[index]);
              })
        ],
      );
    });
  }

  _createProductItem(ProductEntity product) {
    return Container(
      width: 200,
      height: 300,
      child:
      ProductItem(
        onClickItem: () => {Navigator.of(context).pushNamed(Pages.product)},
        product: product,

      ),
    );
  }
}
