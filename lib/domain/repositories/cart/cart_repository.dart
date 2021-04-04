import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:coupon_app/domain/mapper/cart_item_mapper.dart';

abstract class CartRepository{
  Future<List<CartItemMapper>> getCartItems();
  Future<CartItemMapper> findItem(int id, String type);
  Future<int> getQuantity();
  Future<void> addProductToCart(ProductEntity coupon);
  Future<void> removeCouponFromCart(CartItemMapper coupon);
}