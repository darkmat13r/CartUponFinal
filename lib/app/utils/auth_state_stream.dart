import 'dart:async';

import 'package:coupon_app/app/pages/cart/cart_presenter.dart';
import 'package:coupon_app/data/repositories/cart/data_cart_repository.dart';
import 'package:coupon_app/domain/entities/Cart.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:vibration/vibration.dart';

class AuthStateStream {
  static final AuthStateStream _instance = AuthStateStream._internal();

  StreamController<Customer> stream;
  int _cartItem = 0;
  final _repo = DataCartRepository();

  AuthStateStream._internal() {
    stream = StreamController.broadcast();
  }

  factory AuthStateStream() => _instance;



  notifyLoggedIn(Customer user) {
    stream.add(user);
  }


  Stream<Customer> onAuthStateChanged() {
    return stream.stream.asBroadcastStream();
  }


}
