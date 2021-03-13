import 'dart:async';

import 'package:coupon_app/data/repositories/cart/data_cart_repository.dart';
import 'package:coupon_app/domain/entities/coupons/coupon_entity.dart';

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

  addToCart(CouponEntity couponEntity) async{
    _cartItem++;
    await repo.addCouponToCart(couponEntity);
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