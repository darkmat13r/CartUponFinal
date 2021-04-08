import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';

abstract class ProductRepository{
  Future<List<ProductDetail>> getProducts({String categoryId, String country});

  Future<ProductDetail> getById(String productId);
}