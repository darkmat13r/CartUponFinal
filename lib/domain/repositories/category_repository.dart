import 'package:coupon_app/domain/entities/category_detail_entity.dart';

abstract class CategoryRepository{
  Future<List<CategoryDetailEntity>> getCategories();
}