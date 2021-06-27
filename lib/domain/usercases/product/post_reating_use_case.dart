import 'dart:async';

import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class PostRatingUseCase extends CompletableUseCase<PostRatingParams>{
  final ProductRepository _repository;


  PostRatingUseCase(this._repository);

  @override
  Future<Stream<dynamic>> buildUseCaseStream(PostRatingParams params) async{
    final StreamController<dynamic> controller = StreamController();
    try{
     dynamic item = await _repository.postReview(productId: params.productId, rating: params.rating, review: params.review);
      controller.add(item);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }
}

class PostRatingParams{
  int productId;
  int rating;
  String review;

  PostRatingParams({this.productId, this.rating, this.review});
}