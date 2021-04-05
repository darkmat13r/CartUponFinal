import 'dart:convert';
import 'dart:math';

import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';

class Category {
  bool category_status;
  String category_title;
  bool category_type;
  String category_uid;
  int country;
  int id;
  String slug;
  List<ProductDetail> products;

  Category(
      {this.category_status,
      this.category_title,
      this.category_type,
      this.category_uid,
      this.country,
      this.id,
      this.slug,
      this.products});

  factory Category.fromJson(Map<String, dynamic> json) {

    var cat =  Category(
        category_status: json['category_status'],
        category_title: json['category_title'],
        category_type: json['category_type'],
        category_uid: json['category_uid'],
        country: json['country'],
        id: json['id'],
        slug: json['slug'],);
    if(json.containsKey('products')){
      var products = [];
      products = json.containsKey('products') && json['products'] != null
          ? (json['products'] as List).map((e){
            var product = Product.fromJson(e);
            var prodDetails = product.product_details != null && product.product_details.length > 0 ?
            product.product_details.firstWhere((element) => element.lang_type ==json['lang_type'] ) : ProductDetail();
            prodDetails.product = product;
            return prodDetails;
      }).toList()
          : [];
      print("Products        " + (json.containsKey('products') ? "true" : "false"));
      cat.products = products;
    }
    return cat;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_status'] = this.category_status;
    data['category_title'] = this.category_title;
    data['category_type'] = this.category_type;
    data['category_uid'] = this.category_uid;
    data['country'] = this.country;
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['products'] = this.products;
    return data;
  }
}
