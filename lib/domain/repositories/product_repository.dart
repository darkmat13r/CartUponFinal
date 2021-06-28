import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductWithRelated.dart';

abstract class ProductRepository{
  Future<List<ProductDetail>> getProducts({String categoryId,  String type , String filterBy});

  Future<ProductDetail> getById(String productId);
  Future<ProductWithRelated> getProductWithRelated(String slug);
  Future<List<ProductDetail>> search({String query, String filterBy});
  Future<dynamic> postReview({int orderId, int rating, String review});
}