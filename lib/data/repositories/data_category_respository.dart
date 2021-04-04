import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/category_entity.dart';
import 'package:coupon_app/domain/repositories/category_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class DataCategoryRepository extends CategoryRepository {

  static DataCategoryRepository _instance =  DataCategoryRepository._internal();

  Logger _logger;

  DataCategoryRepository._internal(){
    _logger = Logger("DataCouponCategoryRepository");
  }

  factory DataCategoryRepository() => _instance;

  @override
  Future<List<CategoryEntity>> getCategories() async {
    try{
      List<dynamic> data = await HttpHelper.invokeHttp(Constants.categories, RequestType.get);
      _logger.finest("Data ", data);
      dynamic response = data.map((e) => CategoryEntity().fromJson(e)).toList();
      return response;
    }catch(e){
      rethrow;
    }
  }



}

