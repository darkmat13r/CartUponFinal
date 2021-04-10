import 'dart:async';

import 'package:coupon_app/app/components/cart_item.dart';
import 'package:coupon_app/domain/entities/cart.dart';
import 'package:coupon_app/domain/repositories/cart/cart_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetCartItemsUseCase extends CompletableUseCase<void>{

  CartRepository cartRepository;


  GetCartItemsUseCase(this.cartRepository);

  @override
  Future<Stream<Cart>> buildUseCaseStream(void params) async {
    StreamController<Cart> controller = new StreamController();
    try{
      var items = await cartRepository.getCart();
      controller.add(items);
    }catch(e){
      print(e);
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }


}

