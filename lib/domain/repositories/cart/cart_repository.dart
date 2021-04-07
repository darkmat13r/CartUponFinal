import 'package:coupon_app/app/components/cart_item.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/mapper/cart_item_mapper.dart';

abstract class CartRepository{
  Future<List<CartItem>> getCartItems();
  Future<CartItem> findItem(int id, String type);
  Future<int> getQuantity();
  Future<void> addToCart(ProductDetail product);
  Future<void> remove(CartItem productMapper);
}