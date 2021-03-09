
import 'package:coupon_app/domain/entities/coupons/category_detail_entity.dart';

abstract class CouponCategoryRepository{
  Future<List<CategoryDetailEntity>> getCouponCategories();
}