import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupon_app/app/components/banner_product.dart';
import 'package:coupon_app/app/components/product_colors.dart';
import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/products/products_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
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
  Widget get view => Scaffold(
        key: globalKey,
        body: ListView(
          shrinkWrap: true,
          children: [
            _loginCard,
            BannerProduct(),
            SizedBox(
              height: Dimens.spacingNormal,
            ),
            _flashSaleItems("Food"),
            _flashSaleItems("Health"),
            _flashSaleItems("Entertainment"),
            _flashSaleItems("Sports"),
          ],
        ),
      );

  get _loginCard => ControlledWidgetBuilder(builder: (BuildContext context, ProductsController controller){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingMedium),
          child: Column(
            crossAxisAlignment:  CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.completePurchaseFaster.tr(), style: heading6,),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              Text(LocaleKeys.messageSignIn.tr(), style: captionNormal1.copyWith(color: AppColors.neutralGray),),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {
                    controller.login();
                  }, child: Text(LocaleKeys.signIn.tr(), style: buttonText.copyWith(color: AppColors.accent),),

                  ),
                  TextButton(onPressed: () {
                    controller.register();
                  }, child: Text(LocaleKeys.signUp.tr(), style: buttonText.copyWith(color: AppColors.accent),),

                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  });

  Widget _flashSaleItems(String name) => ControlledWidgetBuilder(
          builder: (BuildContext context, ProductsController controller) {
        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    name,
                    style: heading4.copyWith(color: AppColors.primary),
                  )),
                  TextButton(
                    onPressed: () {
                      controller.search();
                    },
                    child: Text(
                      LocaleKeys.seeMore.tr(),
                      style: linkText.copyWith(color: AppColors.accent),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 305,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width/2.1,
                    child: ProductItem(
                        product: controller.products[index],
                        onClickItem: () {}),
                  );
                },
              ),
            )
          ],
        );
      });
}
