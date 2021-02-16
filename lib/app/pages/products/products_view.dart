import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupon_app/app/components/banner_product.dart';
import 'package:coupon_app/app/components/product_colors.dart';
import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/products/products_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProductsPage extends View {
  @override
  State<StatefulWidget> createState() => _ProductsState();
}

class _ProductsState extends ViewState<ProductsPage, ProductsController> {
  _ProductsState() : super(ProductsController());

  @override
  Widget get view => ListView(
        shrinkWrap: true,
        children: [
          _categories,
          BannerProduct(),
          SizedBox(
            height: Dimens.spacingLarge,
          ),
          _recommendedItems()
        ],
      );

  final _categoriesText = [
    "Shirt",
    "Shoes",
    "Books",
    "Electronics",
  ];
  final _categoriesIcon = [
    MaterialCommunityIcons.tshirt_crew,
    MaterialCommunityIcons.shoe_heel,
    MaterialCommunityIcons.book,
    MaterialCommunityIcons.car_electric,
  ];

  get _categories => SizedBox(
        height: 80,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
              _categoriesText.length,
              (index) => _categoryItem(
                  _categoriesIcon[index], _categoriesText[index])),
        ),
      );

  Widget _categoryItem(icon, name) => ControlledWidgetBuilder(
        builder: (BuildContext context, ProductsController controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  SizedBox(
                    width: 36,
                    height: 36,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.neutralLight,
                        borderRadius: BorderRadius.all(Radius.circular(46))
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(Dimens.spacingSmall),
                          child: Icon(
                            icon,
                            size: 16,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimens.spacingNormal,
                  ),
                  Text(
                    name,
                    style: captionNormal2.copyWith(color: AppColors.neutralDark),
                  )
                ],
              ),
            ),
          );
        },
      );

  Widget _recommendedItems(){
    double cardWidth = MediaQuery.of(context).size.width / 3.3;
    double cardHeight = MediaQuery.of(context).size.height / 4.1;
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
       GridView.count(
         // Create a grid with 2 columns. If you change the scrollDirection to
         // horizontal, this produces 2 rows.
         crossAxisCount: 2,
         childAspectRatio: cardWidth / cardHeight,
         physics: NeverScrollableScrollPhysics(),
         shrinkWrap: true,
         children: List.generate(20, (index) {
           return _createProductItem();
         }),
       )
     ],
   );
  }

  _createProductItem() {
    return Container(
      width: 200,
      height: 300,
      child: ProductItem(() => {
        Navigator.of(context).pushNamed(Pages.product)
      }),
    );
  }
}
