import 'package:coupon_app/domain/entities/models/Product.dart';

abstract class ProductRepository{
  Future<List<Product>> getProducts({String categoryId, String country});
}