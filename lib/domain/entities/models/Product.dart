import 'dart:convert';

import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/domain/entities/models/Category.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductGallery.dart';
import 'package:coupon_app/domain/entities/models/ProductVariant.dart';
import 'package:logger/logger.dart';

class Product {
  bool category_type;
  String dis_per;
  int id;
  String price;
  List<ProductGallery> product_gallery;
  List<ProductVariant> product_variants;
  String sale_price;
  String sku;
  int stock;
  String thumb_img;
  String title;
  String uid;
  String valid_from;
  int category_id;
  Category category;
  String valid_to;
  ProductDetail product_detail;
  List<ProductDetail> product_details;

  Product(
      {this.category_type,
      this.dis_per,
      this.id,
      this.price,
      this.product_gallery,
      this.category_id,
      this.product_variants,
      this.sale_price,
      this.sku,
      this.stock,
      this.thumb_img,
      this.title,
      this.uid,
      this.valid_from,
      this.category,
      this.valid_to,
      this.product_detail,
      this.product_details});

  factory Product.fromJson(Map<String, dynamic> json) {
    var product = Product(
      category_type: json['category_type'],
      dis_per: json['dis_per'],
      id: json['id'],
      price: json['price'],
      category_id: json.containsKey('category_id') ? (json['category_id'] is int ? json['category_id']  : 0): 0,
      category: json.containsKey('category_id') ? (json['category_id'] is Map ? Category.fromJson(json['category_id'])  : null): null,
      product_gallery: json['product_gallery'] != null
          ? (json['product_gallery'] as List)
              .map((i) => ProductGallery.fromJson(i))
              .toList()
          : null,
      product_variants: json['product_variants'] != null
          ? (json['product_variants'] as List)
              .map((i) => ProductVariant.fromJson(i))
              .toList()
          : null,
      sale_price: json['sale_price'],
      sku: json['sku'],
      stock: json['stock'],
      thumb_img: json['thumb_img'],
      title: json['title'],
      uid: json['uid'],
      valid_from: json['valid_from'] != null ? json['valid_from'] : null,
      valid_to: json['valid_to'] != null ? json['valid_to'] : null,
      product_details: json['product_detail'] != null
          ? (json['product_detail'] as List)
              .map((e) => ProductDetail.fromJson(e))
              .toList()
          : null,
    );
    try {
      if (product.product_details != null) {
        product.product_detail = product.product_details.firstWhere(
            (element) => element.lang_type == Config().getLanguageId());
      }
    } catch (e) {
      Logger().e(e);
    }
    return product;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_type'] = this.category_type;
    data['dis_per'] = this.dis_per;
    data['id'] = this.id;
    data['price'] = this.price;
    data['sale_price'] = this.sale_price;
    data['sku'] = this.sku;
    data['stock'] = this.stock;
    data['thumb_img'] = this.thumb_img;
    data['category_id'] = this.category_id;
    data['title'] = this.title;
    data['uid'] = this.uid;
    if (this.product_gallery != null) {
      data['product_gallery'] =
          this.product_gallery.map((v) => v.toJson()).toList();
    }
    if (this.product_variants != null) {
      data['product_variants'] =
          this.product_variants.map((v) => v.toJson()).toList();
    }
    if (this.valid_from != null) {
      data['valid_from'] = this.valid_from;
    }
    if (this.valid_to != null) {
      data['valid_to'] = this.valid_to;
    }
    if (this.product_details != null) {
      data['product_detail'] = this.product_details;
    }
    return data;
  }
}
