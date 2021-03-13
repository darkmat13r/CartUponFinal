import 'package:coupon_app/domain/entities/coupons/coupon_entity.dart';
import 'package:coupon_app/domain/mapper/cart_item_mapper.dart';

abstract class CartRepository{
  Future<List<CartItemMapper>> getCartItems();
  Future<void> addCouponToCart(CouponEntity coupon);
  Future<void> removeCouponFromCart(CouponEntity coupon);
}