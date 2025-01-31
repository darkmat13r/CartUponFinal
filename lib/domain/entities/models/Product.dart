import 'dart:convert';

import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/domain/entities/models/Category.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductGallery.dart';
import 'package:coupon_app/domain/entities/models/ProductVariant.dart';
import 'package:coupon_app/domain/entities/models/Seller.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';
import 'package:logger/logger.dart';

class Product {
  bool category_type;
  String dis_per;
  int id;
  String price;
  List<ProductGallery> product_gallery;
  List<ProductVariant> product_variants;
  String sale_price;
  String offer_price;
  String sku;
  int stock;
  String thumb_img;
  String title;
  String uid;
  String valid_from;
  String offer_from;
  String offer_to;
  int category_id;
  int maxQty;
  Category category;
  Seller seller;
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
      this.offer_price,
      this.sku,
      this.stock,
      this.maxQty,
      this.thumb_img,
      this.title,
      this.uid,
      this.valid_from,
      this.category,
      this.valid_to,
      this.offer_from,
      this.offer_to,
      this.seller,
      this.product_detail,
      this.product_details});

  factory Product.fromJson(Map<String, dynamic> json) {
    var product = Product(
      category_type: json['category_type'],
      dis_per: json['dis_per'].toString(),
      id: json['id'],
      price: json['price'].toString(),
      category_id: json.containsKey('category_id')
          ? (json['category_id'] is int ? json['category_id'] : 0)
          : 0,
      category: json.containsKey('category_id')
          ? (json['category_id'] is Map
              ? Category.fromJson(json['category_id'])
              : null)
          : null,
      seller: json.containsKey('seller_id')
          ? (json['seller_id'] is Map
          ? Seller.fromJson(json['seller_id'])
          : null)
          : null,
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
      sale_price: json['sale_price'].toString(),
      offer_price:
          json['offer_price'] != null ? json['offer_price'].toString() : "0",
      sku: json['sku'],
      stock: json['stock'],
      maxQty: json['max_qty'],
      thumb_img: json['thumb_img'] != null
          ? json['thumb_img'].toString().contains("http")
              ? json['thumb_img']
              : "${Constants.baseUrlWithoutV1}${json['thumb_img']}"
          : "",
      title: json['title'],
      uid: json['uid'],
      valid_from: json['valid_from'] != null ? json['valid_from'] : null,
      offer_from: json['offer_from'] != null ? json['offer_from'] : null,
      offer_to: json['offer_to'] != null ? json['offer_to'] : null,
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
    data['max_qty'] = this.maxQty;
    data['stock'] = this.stock;
    data['thumb_img'] = this.thumb_img;
    data['category_id'] = this.category_id;
    data['title'] = this.title;
    data['sale_price'] = this.offer_price;
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

  bool isInOffer() {
    if (offer_from != null && offer_to != null){
      var offerFrom = DateHelper.parseServerDateTime(offer_from);
      var offerTo = DateHelper.parseServerDateTime(offer_to);
      return DateHelper.isValidTime(offerFrom, offerTo);
    }
    return false;
  }

  String getOfferPrice(ProductVariantValue value) {
   /* if (isInOffer() && value != null) {
      return value.offerPrice != null ? value.offerPrice : value.salePrice;
    }*/
    if(isInOffer()){
      return offer_price;
    }
    try {
      if (sale_price != null && double.tryParse(sale_price) > 0)
        return sale_price;
      return price;
    } catch (e) {}
    return price;
  }
  String getVariantOfferPriceByVariant(ProductVariantValue value) {
    if(value == null){
      return getOfferPrice(value);
    }
    if (isInOffer() && value != null) {
      return value.offerPrice;
    }
    try {
      if (value.salePrice != null && double.tryParse(value.salePrice) > 0)
        return value.salePrice;
      return value.price;
    } catch (e) {}
    return value.price;
  }
  bool isVariantRequired() {
    if (product_variants != null) {
      for(var i = 0; i<product_variants.length ; i++){
        if(product_variants[i].required){
          return true;
        }
      }
    }
    return false;
  }
  ProductVariant getRequiredVariant() {
    if (product_variants != null) {
      for(var i = 0; i<product_variants.length ; i++){
        if(product_variants[i].required){
          return product_variants[i];
        }
      }
    }
    return null;
  }


  String getDiscount(ProductVariantValue value) {

    try{
      var offerPrice =  getOfferPrice(value);
      var selectedPrice = price;
      if(value != null){
        selectedPrice = value.price;
      }
      if(double.parse(selectedPrice) > 0)
       return ((1 - double.parse(offerPrice)/ double.parse(selectedPrice))*100).ceil().toString();
    }catch(e){

    }
    return "0";
  }
}
