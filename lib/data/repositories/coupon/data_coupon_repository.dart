import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/coupons/coupon_entity.dart';
import 'package:coupon_app/domain/repositories/coupon/coupon_repository.dart';
import 'package:logging/logging.dart';

class DataCouponRepository extends CouponRepository{

  Logger  _logger;

  static DataCouponRepository _instance =DataCouponRepository._internal();

  DataCouponRepository._internal() {
    _logger = Logger("DataCouponRepository");
  }

  factory DataCouponRepository() => _instance;


  @override
  Future<List<CouponEntity>> getCoupons({String categoryId, String country}) async{
    try{
      print("Locale Code  " +Config().locale.languageCode);
      var uri = Constants.createUriWithParams(Constants.coupons, {
        'category' : categoryId,
        'language' : Config().locale.languageCode
      });
      print("URI " + uri.toString());
      List<dynamic> data = await HttpHelper.invokeHttp(uri, RequestType.get);
      dynamic response =  data.map((e) => CouponEntity().fromJson(e)).toList();
      return response;
    }catch(e){
      print(e.stackTrace.toString());
      rethrow;
    }
  }

}