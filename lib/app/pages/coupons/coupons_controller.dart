import 'package:coupon_app/app/pages/product/product_view.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/dummy.dart';
import 'package:coupon_app/domain/entities/category_entity.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CouponsController extends Controller{

  List<CategoryEntity> categories = [
    CategoryEntity(name: "Automotive", icon: Resources.categoryAuto),
    CategoryEntity(name: "Desserts", icon: Resources.categoryDesserts),
    CategoryEntity(name: "Food", icon: Resources.categoryFood),
    CategoryEntity(name: "Health", icon: Resources.categoryHealth),
    CategoryEntity(name: "Entertainment", icon:Resources.categoryEntertainment),
  ];

  List<ProductEntity> products = DummyProducts.products();

  @override
  void initListeners() {
  }

}