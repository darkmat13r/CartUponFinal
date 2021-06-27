import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/models/CategoryType.dart';
import 'package:coupon_app/domain/repositories/category_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
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
  Future<List<CategoryType>> getCategories({String type}) async {
    try{
      var params = Map<String, String>();
      if(type != null){
        params['category_type'] = type;
      }
      params['lang'] = Config().getLanguageId().toString();
      params['country'] = (await SessionHelper().getSelectedCountryId()).toString();
      var url = Constants.createUriWithParams(Constants.categoriesRoute, params);
      List<dynamic> data = await HttpHelper.invokeHttp(url, RequestType.get);
      _logger.finest("Data ", data);
      dynamic response = data.map((e) => CategoryType.fromJson(e)).toList();
      return response;
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<CategoryType> getCategory(String categoryId) async {
    try{
      Map<String, dynamic> data = await HttpHelper.invokeHttp("${Constants.categoriesRoute}/$categoryId", RequestType.get);
      CategoryType response = CategoryType.fromJson(data);
      return response;
    }catch(e){
      rethrow;
    }
  }




}

