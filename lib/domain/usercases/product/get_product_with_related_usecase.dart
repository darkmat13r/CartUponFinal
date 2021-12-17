import 'dart:async';

import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductWithRelated.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

class GetProductWithRelatedUseCase extends CompletableUseCase<ProductsParams> {
  ProductRepository productRepository;

  Logger _logger;

  GetProductWithRelatedUseCase(this.productRepository) {
    _logger = Logger("GetProductUsecase");
  }

  @override
  Future<Stream<ProductWithRelated>> buildUseCaseStream(ProductsParams params) async{
    StreamController<ProductWithRelated> controller = StreamController();
    try{
      ProductWithRelated productDetail = await productRepository.getProductWithRelated(id: params.id, slug: params.slug);
      controller.add(productDetail);
      controller.close();
    }catch(e){
      controller.addError(e);
    }

    return controller.stream;

  }
}

class ProductsParams{
  String id;
  String slug;
  ProductsParams({this.id, this.slug});
}
