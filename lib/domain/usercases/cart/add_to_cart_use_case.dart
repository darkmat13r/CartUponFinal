import 'dart:async';

import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/repositories/cart/cart_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class AddToCartUseCase extends CompletableUseCase<CartItem>{

  CartRepository _cartRepository;

  Logger _logger;

  AddToCartUseCase(this._cartRepository){
    _logger = Logger("AddToCartUseCase");
  }

  @override
  Future<Stream<void>> buildUseCaseStream(CartItem params) async{
    final StreamController<CartItem> controller =  StreamController();
    try{
      CartItem response = await _cartRepository.addToCart(params.product_id.id.toString(),
          params.variant_value_id != null  ? params.variant_value_id.id.toString() : null, qty: params.qty);
      controller.add(response);
      controller.close();
    }catch(e){
      _logger.finest(e);
      controller.addError(e);
    }
    return controller.stream;
  }



}


