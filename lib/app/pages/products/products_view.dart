import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupon_app/app/components/banner_product.dart';
import 'package:coupon_app/app/components/product_colors.dart';
import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/products/products_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/repositories/banner/data_slider_repository.dart';
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
  _ProductsState() : super(ProductsController(DataSliderRepository()));

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: _body);

  get _body => ControlledWidgetBuilder(builder: (BuildContext context, ProductsController controller){
    return StateView(
      controller.isLoading ? EmptyState.LOADING : EmptyState.CONTENT,
      ListView(
        shrinkWrap: true,
        children: [
          _loginCard,
          _sliders,
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
  });

  get _sliders =>ControlledWidgetBuilder(builder: (BuildContext context, ProductsController controller){
    return controller.sliders != null && controller.sliders.length  > 0 ? CarouselSlider.builder(
        itemCount: controller.sliders.length,
        itemBuilder: (BuildContext context, int index) {
          var bannerUrl = controller.sliders[index].mobileBanner;
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: bannerUrl.startsWith("http")
                  ? Image.network(bannerUrl, fit: BoxFit.cover,)
                  : Image.asset(bannerUrl, fit: BoxFit.cover,));
        },
        options: CarouselOptions(
          height: 240,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          scrollDirection: Axis.horizontal,
        )) : SizedBox();
  });

  get _loginCard => ControlledWidgetBuilder(
          builder: (BuildContext context, ProductsController controller) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.spacingSmall),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(left:Dimens.spacingMedium, right:Dimens.spacingMedium, top: Dimens.spacingSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.completePurchaseFaster.tr(),
                    style: heading6,
                  ),
                  Text(
                    LocaleKeys.messageSignIn.tr(),
                    style:
                        captionNormal1.copyWith(color: AppColors.neutralGray),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          controller.login();
                        },
                        child: Text(
                          LocaleKeys.signIn.tr(),
                          style: buttonText.copyWith(color: AppColors.accent, fontSize: 12),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.register();
                        },
                        child: Text(
                          LocaleKeys.signUp.tr(),
                          style: buttonText.copyWith(color: AppColors.accent, fontSize: 12),
                        ),
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
              height: 280,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
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
