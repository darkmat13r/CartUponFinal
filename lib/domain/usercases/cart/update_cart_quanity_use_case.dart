import 'dart:async';

import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/repositories/cart/cart_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class UpdateCartQuantity extends CompletableUseCase<UpdateQuantityParams>{
  final CartRepository cartRepository;


  UpdateCartQuantity(this.cartRepository);

  @override
  Future<Stream<CartItem>> buildUseCaseStream(UpdateQuantityParams params) async{
    StreamController<CartItem> controller = StreamController();
    try{
      CartItem cartItem = await  cartRepository.updateQuantity(params.cartItemId, params.qty);
      controller.add(cartItem);
      controller.close();
    }catch(e){
      controller.addError(e);
    }

    return controller.stream;
  }

}

class UpdateQuantityParams{
  int cartItemId;
  int qty;

  UpdateQuantityParams(this.cartItemId, this.qty);

}