import 'dart:async';

import 'package:coupon_app/domain/entities/models/WhishlistItem.dart';
import 'package:coupon_app/domain/repositories/whishlist_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetWhishlistUseCase extends CompletableUseCase<void>{
  final WhishlistRepository _repository;


  GetWhishlistUseCase(this._repository);

  @override
  Future<Stream<List<WhishlistItem>>> buildUseCaseStream(void params) async{
    final StreamController<List<WhishlistItem>> controller = StreamController();
    try{
      List<WhishlistItem> whishlistItems = await _repository.getWhishlist();
      controller.add(whishlistItems);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }

}