import 'dart:async';

import 'package:coupon_app/app/pages/cart/cart_presenter.dart';
import 'package:coupon_app/data/repositories/cart/data_cart_repository.dart';
import 'package:coupon_app/domain/entities/Cart.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:vibration/vibration.dart';

class CartStream {
  static final CartStream _instance = CartStream._internal();
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  StreamController<int> stream;
  int _cartItem = 0;
  final _repo = DataCartRepository();

  CartStream._internal() {
    stream = StreamController.broadcast();
    fetchQuantity();
  }

  factory CartStream() => _instance;

  addToCart(Product productDetail, ProductVariantValue variantValue) async {
    if (_cartItem == null) {
      _cartItem = 0;
    }
    _cartItem++;

    await _repo.addToCart(productDetail.id.toString(),
        variantValue != null ? variantValue.id.toString() : "");
    fetchQuantity();
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
    analytics.logAddToCart(
      currency: 'KD',
      value: double.tryParse(productDetail.getVariantOfferPriceByVariant(variantValue)),
      itemId: productDetail.id.toString(),
      itemName: productDetail.product_detail?.name ?? "",
      itemCategory: productDetail.category_id.toString(),
      quantity: 1,
      price: double.tryParse(productDetail.getVariantOfferPriceByVariant(variantValue)),
    );
  }

  fetchQuantity() async {
    Cart cart = await _repo.getCart();
    updateCart(cart);
  }

  updateCart(Cart cart) {
    _cartItem = cart.total_qty;
    updateQuantity(cart.total_qty);
  }

  updateQuantity(int qty) {
    stream.add(qty);
  }

  int getCurrentItemCount() => _cartItem;

  Stream<int> onAddToCart() {
    return stream.stream.asBroadcastStream();
  }

  void clear() {
    updateCart(Cart());
  }
}
