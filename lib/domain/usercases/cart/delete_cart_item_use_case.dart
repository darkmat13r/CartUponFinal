import 'dart:async';

import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/repositories/cart/cart_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class DeleteCartItemUseCase extends CompletableUseCase<CartItem>{

  CartRepository cartRepository;

  Logger _logger;

  DeleteCartItemUseCase(this.cartRepository){
    _logger = Logger("DeleteCartItemUseCase");
  }

  @override
  Future<Stream<void>> buildUseCaseStream(CartItem params) async{

    StreamController<void> controller = StreamController();
    try{
      var res = await cartRepository.remove(params);
      controller.add(res);
      controller.close();
    }catch(e){
      _logger.finest(e);
      controller.addError(e);
    }
    return controller.stream;
  }


}