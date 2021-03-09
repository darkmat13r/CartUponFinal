import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/category_entity.dart';
import 'package:coupon_app/domain/entities/coupons/category_detail_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ExploreController extends Controller{
  List<CategoryDetailEntity> categories = [
    /*CategoryDetailEntity(name: "Automotive", icon: Resources.categoryAuto),
    CategoryDetailEntity(name: "Desserts", icon: Resources.categoryDesserts),
    CategoryDetailEntity(name: "Food", icon: Resources.categoryFood),
    CategoryDetailEntity(name: "Health", icon: Resources.categoryHealth),
    CategoryDetailEntity(name: "Entertainment", icon:Resources.categoryEntertainment),*/
  ];
  @override
  void initListeners() {
  }

  void search(){
    Navigator.of(getContext()).pushNamed(Pages.search);
  }
}