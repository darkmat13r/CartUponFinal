import 'dart:async';

import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/WhishlistItem.dart';
import 'package:coupon_app/domain/repositories/whishlist_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddToWhishlistUseCase extends CompletableUseCase<Product>{
  final WhishlistRepository _repository;


  AddToWhishlistUseCase(this._repository);

  @override
  Future<Stream<WhishlistItem>> buildUseCaseStream(Product params) async{
    final StreamController<WhishlistItem> controller = StreamController();
    try{
      WhishlistItem item = await _repository.addToWhishlist(params);
      controller.add(item);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }

}