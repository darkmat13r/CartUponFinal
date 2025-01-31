import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:flutter/cupertino.dart';

class CartItemMapper {
  int productId;
  String type;
  String price;
  String name;
  String shortDescription;
  String fullDescription;
  String image;
  int quantity;

  static const String COUPON = "coupon";
  static const String PRODUCT = "product";

  CartItemMapper(
      {@required this.productId,
      this.name,
      this.type,
      this.price,
      this.image,
      this.shortDescription,
      this.fullDescription,
      this.quantity});

  static CartItemMapper withProduct(ProductDetail product) {
    return CartItemMapper(
        productId: product.id,
        name: product.name,
        shortDescription: product.short_description,
        fullDescription: product.full_description,
        price: product.product.price,
        image: product.product.thumb_img,
        type: COUPON,
        quantity: 1);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': productId,
      'name': name,
      'shortDescription': shortDescription,
      'fullDescription': fullDescription,
      'price': price,
      'image': image,
      'type': type,
      'quantity': quantity == null ? 1 : quantity
    };
  }

  static createFromMap(Map<String, dynamic> e) {
    return CartItemMapper(
      productId: e['id'],
      name: e['name'],
      price: e['price'].toString(),
      fullDescription: e['fullDescription'],
      shortDescription: e['shortDescription'],
      image: e['image'].toString(),
      quantity: e['quantity'],
      type: e['type'].toString(),
    );
  }
}
