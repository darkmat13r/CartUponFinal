import 'dart:async';

import 'package:coupon_app/data/repositories/cart/data_cart_repository.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';

class CartStream{
  static final CartStream _instance = CartStream._internal();
  StreamController<int> stream;
  int _cartItem = 0;
  final repo = DataCartRepository();
  CartStream._internal(){
    stream = StreamController.broadcast();
    fetchQuantity();
  }

  factory CartStream() => _instance;

  addToCart(ProductDetail productDetail, ProductVariantValue variantValue) async{
    _cartItem++;
    await repo.addToCart(productDetail, variantValue);
    var items = await repo.getQuantity();
    stream.add(items);
  }

  fetchQuantity() async{
    var items = await repo.getQuantity();
    stream.add(items);
  }
  int getCurrentItemCount() => _cartItem;

  Stream<int> onAddToCart(){
    return stream.stream.asBroadcastStream();
  }
}