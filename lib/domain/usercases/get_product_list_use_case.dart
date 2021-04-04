import 'dart:async';

import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetProductListUseCase extends CompletableUseCase<CouponFilterParams>{

  ProductRepository _productRepository;


  GetProductListUseCase(this._productRepository);

  @override
  Future<Stream<List<ProductEntity>>> buildUseCaseStream(CouponFilterParams params) async{
    StreamController<List<ProductEntity>> controller = new StreamController();
    try{
      List<ProductEntity> products = await _productRepository.getProducts(categoryId: params.categoryId);
      controller.add(products);
    }catch(e){
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }

}


class CouponFilterParams{
  String categoryId;

  CouponFilterParams({this.categoryId});
}