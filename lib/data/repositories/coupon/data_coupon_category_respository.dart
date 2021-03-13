import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/coupons/category_detail_entity.dart';
import 'package:coupon_app/domain/entities/coupons/coupon_entity.dart';
import 'package:coupon_app/domain/repositories/coupon/category_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class DataCouponCategoryRepository extends CouponCategoryRepository {

  static DataCouponCategoryRepository _instance =  DataCouponCategoryRepository._internal();

  Logger _logger;

  DataCouponCategoryRepository._internal(){
    _logger = Logger("DataCouponCategoryRepository");
  }

  factory DataCouponCategoryRepository() => _instance;

  @override
  Future<List<CategoryDetailEntity>> getCouponCategories() async {
    try{
      List<dynamic> data = await HttpHelper.invokeHttp(Constants.couponDetails, RequestType.get);
      _logger.finest("Data ", data);
      dynamic response = data.map((e) => CategoryDetailEntity().fromJson(e)).toList();
      return response;
    }catch(e){
      rethrow;
    }
  }



}

