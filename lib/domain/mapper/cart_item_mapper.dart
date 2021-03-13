import 'package:coupon_app/domain/entities/coupons/coupon_entity.dart';
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

  static CartItemMapper withCoupon(CouponEntity coupon) {
    return CartItemMapper(
        productId: coupon.id,
        name: coupon.name,
        shortDescription: coupon.shortDescription,
        fullDescription: coupon.fullDescription,
        price: coupon.couponId.price,
        image: coupon.couponId.thumbImg,
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
    print("CreateFromMap ${e}");
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
