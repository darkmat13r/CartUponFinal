import 'package:coupon_app/app/pages/coupons/coupons_presenter.dart';
import 'package:coupon_app/domain/repositories/coupon/category_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ExplorePresenter extends CouponPresenter{

  ExplorePresenter(CouponCategoryRepository couponCategoryRepository) : super(couponCategoryRepository);


  @override
  void dispose() {
    super.dispose();
  }

}