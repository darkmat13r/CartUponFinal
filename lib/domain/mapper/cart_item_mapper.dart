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

  CartItemMapper({
    @required this.productId, this.name, this.type, this.price, this.image, this.shortDescription, this.fullDescription, this.quantity});

  static CartItemMapper withCoupon(CouponEntity coupon) {
    return CartItemMapper(productId: coupon.id,
        name: coupon.name,
        shortDescription: coupon.shortDescription,
        fullDescription: coupon.fullDescription,
        price: coupon.couponId.price,
        image: coupon.couponId.thumbImg,
        type:  COUPON,
        quantity:  1
    );
  }

}