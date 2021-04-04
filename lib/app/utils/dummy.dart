import 'dart:convert';

import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:coupon_app/generated/json/base/json_convert_content.dart';

class DummyProducts{
  static String productsJson = '[{"id":1,"name":"Coupon ENg","short_description":"Coupon Short","full_description":"Full Desc","meta_title":"Coupomn Meta Title","meta_desc":"Descriptuo","lang_type":0,"slug":"new-coupons","product_id":{"id":1,"title":"New Coupons","uid":"59016efa-cd63-453e-a08a-50af3d27ae2f","thumb_img":"https:\/\/cart-upon-api.herokuapp.com\/media\/from-the-clay-oven-jamawar.jpg","price":"100.000","sale_price":"90.000","dis_per":"10.000","stock":10,"sku":null,"valid_from":null,"valid_to":null,"category_type":false,"product_gallery":[{"id":1,"image":"https:\/\/cart-upon-api.herokuapp.com\/media\/download.jpeg.jpg","product_id":1},{"id":2,"image":"https:\/\/cart-upon-api.herokuapp.com\/media\/download.jpeg_XqAUWho.jpg","product_id":1}],"product_variants":[{"id":1,"name":"color","required":true,"display_as":"v_list","product_variant_values":[{"id":1,"value":"red","price":"100.00","stock":1,"image":"https:\/\/cart-upon-api.herokuapp.com\/media\/from-the-clay-oven-jamawar_NeSMJhU.jpg","variant_id":1},{"id":2,"value":"Blue","price":"200.00","stock":2,"image":"https:\/\/cart-upon-api.herokuapp.com\/media\/how-to-makeup-your-face-like-beauty-salon-1024x683-1-1.jpg","variant_id":1}]}]}},{"id":3,"name":"Coupon ENg","short_description":"Coupon Short","full_description":"Full Desc","meta_title":"Coupomn Meta Title","meta_desc":"Descriptuo","lang_type":0,"slug":"new-coupons-2","product_id":{"id":2,"title":"New Coupons","uid":"7273f5a4-2497-4385-ab84-0cc856edf6b2","thumb_img":"https:\/\/cart-upon-api.herokuapp.com\/media\/from-the-clay-oven-jamawar_TXgKFSp.jpg","price":"100.000","sale_price":"90.000","dis_per":"10.000","stock":10,"sku":"saadsd123","valid_from":"2021-03-05T13:15:30Z","valid_to":"2021-11-05T13:15:30Z","category_type":false,"product_gallery":[{"id":3,"image":"https:\/\/cart-upon-api.herokuapp.com\/media\/download.jpeg_n6qpRfS.jpg","product_id":2},{"id":4,"image":"https:\/\/cart-upon-api.herokuapp.com\/media\/download.jpeg_oTflezN.jpg","product_id":2}],"product_variants":[{"id":2,"name":"color","required":true,"display_as":"v_list","product_variant_values":[{"id":3,"value":"red","price":"100.00","stock":1,"image":"https:\/\/cart-upon-api.herokuapp.com\/media\/from-the-clay-oven-jamawar_xMfytc6.jpg","variant_id":2},{"id":4,"value":"Blue","price":"200.00","stock":2,"image":"https:\/\/cart-upon-api.herokuapp.com\/media\/how-to-makeup-your-face-like-beauty-salon-1024x683-1-1_NxSIVX3.jpg","variant_id":2}]}]}}]';

  static List<ProductEntity> products(){
    List<dynamic> products = jsonDecode(productsJson);
    return products.map((e) => ProductEntity().fromJson(e)).toList();
  }
}