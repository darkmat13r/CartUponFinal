import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/mapper/cart_item_mapper.dart';

abstract class CartRepository{
  Future<List<CartItemMapper>> getCartItems();
  Future<CartItemMapper> findItem(int id, String type);
  Future<int> getQuantity();
  Future<void> addProductToCart(ProductDetail product);
  Future<void> removeCouponFromCart(CartItemMapper productMapper);
}