import 'dart:async';

import 'package:coupon_app/domain/entities/models/Category.dart';
import 'package:coupon_app/domain/entities/models/CategoryType.dart';
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
  Future<Stream<List<CategoryType>>> buildUseCaseStream(dynamic params) async {
    final StreamController<List<CategoryType>> controller = StreamController();
    try{
      List<CategoryType> categories = await _couponCategoryRepository.getCategories();
      controller.add(categories);
      controller.close();
    }catch(e){
      print("Eprrrrrrrrrr > " + e);
      _logger.shout('Couldn\'t load sliders', e);
      controller.addError(e);
    }
    return controller.stream;
  }

}