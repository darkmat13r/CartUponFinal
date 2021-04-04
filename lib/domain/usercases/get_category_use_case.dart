import 'dart:async';

import 'package:coupon_app/domain/entities/category_entity.dart';
import 'package:coupon_app/domain/repositories/category_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class GetCouponCategoryUseCase extends CompletableUseCase<void>{

  CategoryRepository _couponCategoryRepository;

  Logger _logger;
  GetCouponCategoryUseCase(this._couponCategoryRepository){
   _logger = Logger("GetCouponCategoryUseCase");
  }

  @override
  Future<Stream<List<CategoryEntity>>> buildUseCaseStream(dynamic params) async {
    final StreamController<List<CategoryEntity>> controller = StreamController();
    try{
      List<CategoryEntity> categories = await _couponCategoryRepository.getCategories();
      controller.add(categories);
      controller.close();
    }catch(e){
      controller.addError(e);
      _logger.shout('Couldn\'t load sliders', e);
    }
    return controller.stream;
  }

}