import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ExploreController extends Controller{
  List<CategoryEntity> categories = [
    CategoryEntity(name: "Food", icon: Resources.categoryFood),
    CategoryEntity(name: "Health", icon: Resources.categoryHealth),
    CategoryEntity(name: "Entertainment", icon:Resources.categoryEntertainment),
    CategoryEntity(name: "Sports", icon: Resources.categorySports),
  ];
  @override
  void initListeners() {
  }

  void search(){
    Navigator.of(getContext()).pushNamed(Pages.search);
  }
}