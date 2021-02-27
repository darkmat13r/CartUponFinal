import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/dummy.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ProductsController extends Controller{
  List<ProductEntity> products = DummyProducts.products();
  @override
  void initListeners() {
  }


  search(){
    Navigator.of(getContext()).pushNamed(Pages.search);
  }

  login(){
    Navigator.of(getContext()).pushNamed(Pages.welcome);
  }
  register(){
    Navigator.of(getContext()).pushNamed(Pages.welcome);
  }
}