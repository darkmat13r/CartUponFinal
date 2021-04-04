import 'package:coupon_app/domain/entities/ad_banner_entity.dart';
import 'package:coupon_app/domain/entities/category_entity.dart';
import 'package:coupon_app/domain/entities/home/home_entity.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:coupon_app/domain/entities/slider_banner_entity.dart';

extension HomeEntityMapping on HomeEntity{



  HomeEntity fromJsonMapper(Map<String, dynamic> json){
    var entity =  HomeEntity();
    if (json['sliders'] != null) {
      print("Sliders =>>>>>>>>>>>>>>>>>>>>>>>>${json['sliders']}");
      entity.sliders = (json['sliders'] as List).map((v) => SliderBannerEntity().fromJson(v)).toList();
    }
    if (json['adbanners'] != null) {
      entity.adBanners = (json['adbanners'] as List).map((v) => AdBannerEntity().fromJson(v)).toList();
    }
    if (json['sections'] != null) {
      entity.sections = (json['sections'] as List).map((v){
       var category = CategoryEntity()
          .fromJson(v);
       if(v['products'] != null)
       category.category.products = (v['products'] as List).map((e) => ProductProductId().fromJson(e));
       return category;
      })
          .toList();
    }
    if (json['Feature_products'] != null) {
      entity.featuredProducts = (json['Feature_products'] as List).map((v) => ProductProductId().fromJson(v)).toList();
    }
    return entity;
  }
}