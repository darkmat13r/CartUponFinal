import 'dart:async';

import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

class GetProductUseCase extends CompletableUseCase<String> {
  ProductRepository productRepository;

  Logger _logger;

  GetProductUseCase(this.productRepository) {
    _logger = Logger("GetProductUsecase");
  }

  @override
  Future<Stream<ProductDetail>> buildUseCaseStream(String productId) async{
    StreamController<ProductDetail> controller = StreamController();
    _logger.finest("-=---------> PRoductId ${productId}");
    try{
      ProductDetail productDetail = await productRepository.getById(productId);
      controller.add(productDetail);
    }catch(e){
      controller.addError(e);
    }
    controller.close();
    return controller.stream;

  }
}
