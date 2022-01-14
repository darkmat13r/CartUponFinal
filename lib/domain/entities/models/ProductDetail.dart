import 'dart:convert';

import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/Rating.dart';
import 'package:logger/logger.dart';

class ProductDetail {
  String full_description;
  int id;
  int lang_type;
  String meta_desc;
  String meta_title;
  String name;
  Product product;
  String short_description;
  String slug;
  String in_box;
  String notes;

  String warranty;

  ProductDetail(
      {this.full_description,
      this.id,
      this.lang_type,
      this.meta_desc,
      this.meta_title,
      this.name,
      this.product,
      this.short_description,
      this.in_box,
      this.notes,
      this.warranty,
      this.slug});

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    var productDetails = ProductDetail(
      full_description: json['full_description'],
      id: json['id'],
      lang_type: json['lang_type'],
      meta_desc: json['meta_desc'],
      meta_title: json['meta_title'],
      name: json['name'],
      short_description: json['short_description'],
      slug: json['slug'],
      in_box: json['in_box'],
      notes: json['notes'],
      warranty: json['warranty'],
    );
    try {
      productDetails.product = json['product_id'] != null
          ? Product.fromJson(json['product_id'])
          : null;
    } catch (e) {
      //   Logger().e(e.stackTrace);
    }
    return productDetails;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_description'] = this.full_description;
    data['id'] = this.id;
    data['lang_type'] = this.lang_type;
    data['meta_desc'] = this.meta_desc;
    data['meta_title'] = this.meta_title;
    data['name'] = this.name;
    data['short_description'] = this.short_description;
    data['slug'] = this.slug;
    data['in_box'] = this.in_box;
    data['notes'] = this.notes;
    data['warranty'] = this.warranty;
    if (this.product != null) {
      data['product_id'] = this.product.toJson();
    }
    return data;
  }
}
