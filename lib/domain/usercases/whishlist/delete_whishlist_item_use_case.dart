import 'dart:async';

import 'package:coupon_app/domain/entities/models/WhishlistItem.dart';
import 'package:coupon_app/domain/repositories/whishlist_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class DeleteWhishlistItemUseCase extends CompletableUseCase<WhishlistItem>{
  final WhishlistRepository _repository;


  DeleteWhishlistItemUseCase(this._repository);

  @override
  Future<Stream<List<WhishlistItem>>> buildUseCaseStream(WhishlistItem params) async{
    final StreamController<List<WhishlistItem>> controller = StreamController();
    try{
      await _repository.remove(params);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }
}