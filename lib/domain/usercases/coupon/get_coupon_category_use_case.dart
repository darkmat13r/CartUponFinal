import 'dart:async';

import 'package:coupon_app/domain/entities/coupons/category_detail_entity.dart';
import 'package:coupon_app/domain/repositories/coupon/category_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class GetCouponCategoryUseCase extends CompletableUseCase<void>{

  CouponCategoryRepository _couponCategoryRepository;

  Logger _logger;
  GetCouponCategoryUseCase(this._couponCategoryRepository){
   _logger = Logger("GetCouponCategoryUseCase");
  }

  @override
  Future<Stream<List<CategoryDetailEntity>>> buildUseCaseStream(dynamic params) async {
    final StreamController<List<CategoryDetailEntity>> controller = StreamController();
    try{
      List<CategoryDetailEntity> categories = await _couponCategoryRepository.getCouponCategories();
      controller.add(categories);
      controller.close();
    }catch(e){
      controller.addError(e);
      _logger.shout('Couldn\'t load sliders', e);
    }
    return controller.stream;
  }

}