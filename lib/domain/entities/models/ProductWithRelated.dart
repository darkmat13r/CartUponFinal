import 'package:coupon_app/domain/entities/models/ProductDetail.dart';

class ProductWithRelated{
  ProductDetail productDetail;
  List<ProductDetail> relatedProducts;

  ProductWithRelated({this.productDetail, this.relatedProducts});


  factory ProductWithRelated.fromJson(Map<String, dynamic> json) {
    return ProductWithRelated(
      productDetail: json['product'] != null ? ProductDetail.fromJson(json['product']) : null,
      relatedProducts:  json['related_product'] != null ? (json['related_product'] as List).map((e) => ProductDetail.fromJson(e)).toList() : []

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.productDetail;
    data['related_product'] = this.relatedProducts;
    return data;
  }
}