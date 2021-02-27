import 'dart:async';

class CartStream{
  static final CartStream _instance = CartStream._internal();
  StreamController<int> stream;
  int _cartItem = 0;
  CartStream._internal(){
    stream = StreamController.broadcast();
  }

  factory CartStream() => _instance;

  addToCart(){
    _cartItem++;
    stream.add(_cartItem);
  }

  int getCurrentItemCount() => _cartItem;

  Stream<int> onAddToCart(){
    return stream.stream.asBroadcastStream();
  }
}