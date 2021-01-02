import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/components/rating.dart';
import 'package:coupon_app/app/pages/home/home_controller.dart';
import 'package:coupon_app/app/pages/login/login_view.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends View {
  @override
  State<StatefulWidget> createState() => HomePageView();
}

class HomePageView extends ViewState<HomePage, HomeController> {
  HomePageView() : super(HomeController());

  @override
  Widget get view => Scaffold(key: globalKey, body: _body);

  Widget get _appBar => Container(
        height: 72,
        decoration: BoxDecoration(
            border: Border.fromBorderSide(
                BorderSide(color: AppColors.neutralLight))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.spacingMedium, 0, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Feather.search,
                      color: AppColors.primary,
                    ),
                    hintText: LocaleKeys.hintSearchProduct.tr()),
              )),
              SizedBox(
                width: Dimens.spacingMedium,
              ),
              Ink(
                decoration: const ShapeDecoration(shape: CircleBorder()),
                child: IconButton(
                  icon: Icon(Feather.heart),
                  color: AppColors.neutralGray,
                  onPressed: () {},
                ),
              ),
              Ink(
                decoration: const ShapeDecoration(shape: CircleBorder()),
                child: IconButton(
                  icon: Icon(Feather.bell),
                  color: AppColors.neutralGray,
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      );

  Widget get _body => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            _appBar,
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            _banners,
            _categories,
            _flashSaleItems( LocaleKeys.flashSale.tr(),),
            SizedBox(
              height: Dimens.spacingNormal,
            ),
            _flashSaleItems( LocaleKeys.megaSale.tr(),),
            _recommendedItems,
          ],
        ),
      );

  Widget get _banners => CarouselSlider(
      options: CarouselOptions(height: 200.0),
      items: [0, 1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return _bannerImage;
          },
        );
      }).toList());

  get _bannerImage => Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: [
            Image(
              image: AssetImage(Resources.promotion),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Super Flash Sale",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "50% Off",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  Text(
                    "08 : 24 : 52",
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ));

  get _categories => Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  LocaleKeys.category.tr(),
                  style: heading5.copyWith(color: AppColors.neutralDark),
                )),
                TextButton(
                  onPressed: () {},
                  child: Text(LocaleKeys.moreCategory.tr() , style: linkText,),
                )
              ],
            ),
          ),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _createCategoryItem("Coupons", MaterialCommunityIcons.ticket),
                _createCategoryItem(
                    "Shoes Men", MaterialCommunityIcons.shoe_formal),
                _createCategoryItem(
                    "T-Shirts", MaterialCommunityIcons.tshirt_v),
                _createCategoryItem(
                    "Bags", MaterialCommunityIcons.bag_carry_on),
                _createCategoryItem(
                    "Bags Women", MaterialCommunityIcons.bag_personal_outline),
                _createCategoryItem(
                    "Shoes Women", MaterialCommunityIcons.shoe_heel),
              ],
            ),
          )
        ],
      );

  Widget _flashSaleItems(String name) => Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  name,
                  style: heading5.copyWith(color: AppColors.neutralDark),
                )),
                TextButton(
                  onPressed: () {},
                  child: Text(LocaleKeys.seeMore.tr() , style: linkText,),
                )
              ],
            ),
          ),
          Container(
            height: 300,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
                _createProductItem(),
              ],
            ),
          )
        ],
      );

  get _recommendedItems => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                image: AssetImage(Resources.recommended),
              ),
            ),
          ),
          GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            childAspectRatio: 160 / 240,
            physics: NeverScrollableScrollPhysics(),
            // to disable GridView's scrolling
            shrinkWrap: true,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(20, (index) {
              return _createProductItem();
            }),
          )
        ],
      );

  _createProductItem() {
    return ControlledWidgetBuilder<HomeController>(builder: (context,HomeController controller) =>  Container(
      width: 200,
      height: 300,
      child: ProductItem(()=>{controller.goToProductDetails()}),
    ));
  }

  _createCategoryItem(String name, IconData icon) {
    return Container(
      width: 80,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: Column(
          children: [
            Ink(
              decoration: const ShapeDecoration(
                  shape: const CircleBorder(
                      side: BorderSide(
                          width: Dimens.borderWidth,
                          color: AppColors.neutralLight))),
              child: IconButton(
                icon: Icon(icon),
                color: AppColors.primary,
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: Dimens.spacingSmall,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
              style: captionNormal2,
            )
          ],
        ),
      ),
    );
  }
}
