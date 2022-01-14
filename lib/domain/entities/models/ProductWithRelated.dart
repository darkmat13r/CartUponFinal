import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:logger/logger.dart';

import 'Rating.dart';

class ProductWithRelated{
  ProductDetail productDetail;
  List<ProductDetail> relatedProducts;
  List<Rating> ratings;

  ProductWithRelated({this.productDetail, this.relatedProducts, this.ratings});


  factory ProductWithRelated.fromJson(Map<String, dynamic> json) {
    return ProductWithRelated(
      productDetail: json['product'] != null ? ProductDetail.fromJson(json['product']) : null,
      relatedProducts:  json['related_product'] != null ? (json['related_product'] as List).map((e){
        return ProductDetail.fromJson(e);
      }).toList() : [],
      ratings:  json['ratings'] != null ? (json['ratings'].map<Rating>((e) {
      return Rating.fromJson(e);
    }).toList()) : []
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.productDetail;
    data['related_product'] = this.relatedProducts;
    data['ratings'] = this.ratings;
    return data;
  }
}