

import 'package:coupon_app/domain/entities/coupons/coupon_entity.dart';

abstract class CouponRepository{
  Future<List<CouponEntity>> getCoupons({String categoryId, String country});
}