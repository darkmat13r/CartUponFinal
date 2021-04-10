import 'dart:async';

import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetProductListUseCase extends CompletableUseCase<ProductFilterParams>{

  ProductRepository _productRepository;


  GetProductListUseCase(this._productRepository);

  @override
  Future<Stream<List<ProductDetail>>> buildUseCaseStream(ProductFilterParams params) async{
    StreamController<List<ProductDetail>> controller = new StreamController();
    try{
      List<ProductDetail> products = await _productRepository.getProducts(categoryId: params.categoryId);
      controller.add(products);
      controller.close();
    }catch(e){
      controller.addError(e);
    }

    return controller.stream;
  }

}


class ProductFilterParams{
  String categoryId;

  ProductFilterParams({this.categoryId});
}