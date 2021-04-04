

import 'package:coupon_app/domain/entities/product_entity.dart';

abstract class ProductRepository{
  Future<List<ProductEntity>> getProducts({String categoryId, String country});
}