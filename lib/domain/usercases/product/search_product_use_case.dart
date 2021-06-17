import 'dart:async';

import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SearchProductUseCase extends CompletableUseCase<SearchProductParams>{

  final ProductRepository _repository;


  SearchProductUseCase(this._repository);

  @override
  Future<Stream<List<ProductDetail>>> buildUseCaseStream(params) async {
    StreamController<List<ProductDetail>> controller = StreamController();
    try{
      List<ProductDetail> products = await _repository.search(query: params.query, filterBy: params.filterBy);
      controller.add(products);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }

}

class SearchProductParams{
  String query;
  String filterBy;

  SearchProductParams({this.query, this.filterBy});
}