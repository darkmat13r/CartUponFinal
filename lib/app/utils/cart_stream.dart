import 'dart:async';

import 'package:coupon_app/app/pages/cart/cart_presenter.dart';
import 'package:coupon_app/data/repositories/cart/data_cart_repository.dart';
import 'package:coupon_app/domain/entities/cart.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';

class CartStream{
  static final CartStream _instance = CartStream._internal();



  StreamController<int> stream;
  int _cartItem = 0;
  final _repo = DataCartRepository();
  CartStream._internal(){
    stream = StreamController.broadcast();
    fetchQuantity();
  }

  factory CartStream() => _instance;

  addToCart(Product productDetail, ProductVariantValue variantValue) async{
    _cartItem++;
    await _repo.addToCart(productDetail.id.toString(),variantValue != null ?  variantValue.id : "");
    fetchQuantity();
  }

  fetchQuantity() async{
    Cart cart = await _repo.getCart();
   updateCart(cart);
  }
  updateCart(Cart cart){
    _cartItem =  cart.quantity;
    updateQuantity(cart.quantity);
  }
  updateQuantity(int qty){
    stream.add(qty);
  }
  int getCurrentItemCount() => _cartItem;

  Stream<int> onAddToCart(){
    return stream.stream.asBroadcastStream();
  }
}