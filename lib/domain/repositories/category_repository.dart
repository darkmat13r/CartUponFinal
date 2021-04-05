
import 'package:coupon_app/domain/entities/models/Category.dart';
import 'package:coupon_app/domain/entities/models/CategoryType.dart';

abstract class CategoryRepository{
  Future<List<CategoryType>> getCategories();


}