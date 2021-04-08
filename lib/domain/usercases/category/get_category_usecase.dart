import 'dart:async';

import 'package:coupon_app/domain/entities/models/CategoryType.dart';
import 'package:coupon_app/domain/repositories/category_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class GetCategoryUseCase extends CompletableUseCase<String>{

  CategoryRepository _repository;

  Logger _logger;

  GetCategoryUseCase(this._repository){
    _logger =  Logger("GetCategoryUseCase");
  }

  @override
  Future<Stream<CategoryType>> buildUseCaseStream(String categoryId) async{
    StreamController<CategoryType> controller = new StreamController();
    try{
      CategoryType category = await _repository.getCategory(categoryId);
      controller.add(category);
    }catch(e){
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }

}