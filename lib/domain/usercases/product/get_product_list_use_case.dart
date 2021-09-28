import 'dart:async';

import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class GetProductListUseCase extends CompletableUseCase<ProductFilterParams> {
  ProductRepository _productRepository;

  GetProductListUseCase(this._productRepository);

  @override
  Future<Stream<List<ProductDetail>>> buildUseCaseStream(
      ProductFilterParams params) async {
    StreamController<List<ProductDetail>> controller = new StreamController();
    try {
      List<ProductDetail> products = await _productRepository.getProducts(
          categoryId: params.categoryId,
          type: params.productType,
          filterBy: params.filterBy);
      controller.add(products);
      controller.close();
    } catch (e) {
      Logger().e(e.stackTrace);
      controller.addError(e);
    }

    return controller.stream;
  }
}

class ProductFilterParams {
  String categoryId;
  String productType;
  String filterBy;

  ProductFilterParams({this.categoryId, this.productType, this.filterBy});
}
