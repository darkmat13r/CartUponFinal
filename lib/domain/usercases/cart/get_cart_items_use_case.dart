import 'dart:async';

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
      var items = await cartRepository.getCartItems();
      var quantity = await cartRepository.getQuantity();
      double total = 0;
      items.forEach((element) {
        total += double.parse(element.price) * element.quantity ;
      });
      controller.add(Cart(quantity: quantity, cartItems: items, total: total));
    }catch(e){
      print(e.stackTrace);
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }


}

