import 'package:coupon_app/app/components/cart_item.dart';
import 'package:coupon_app/domain/entities/cart.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';
import 'package:coupon_app/domain/mapper/cart_item_mapper.dart';

abstract class CartRepository{
  Future<Cart> getCart();
  Future<CartItem> findItem(int id, String type);
  Future<CartItem> updateQuantity(int cartItemId, int quantity);
  Future<int> getQuantity();
  Future<CartItem> addToCart(String productId, String variantValueId, {int qty});
  Future<void> remove(CartItem productMapper);
}