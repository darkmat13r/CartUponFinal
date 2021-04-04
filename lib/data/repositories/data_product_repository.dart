import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:logging/logging.dart';

class DataProductRepository extends ProductRepository{

  Logger  _logger;

  static DataProductRepository _instance =DataProductRepository._internal();

  DataProductRepository._internal() {
    _logger = Logger("DataCouponRepository");
  }

  factory DataProductRepository() => _instance;


  @override
  Future<List<ProductEntity>> getProducts({String categoryId, String country}) async{
    try{
      var uri = Constants.createUriWithParams(Constants.products, {
        'category' : categoryId,
        //'lang' : Config().locale.languageCode
        'lang' : "0"
      });
      print("URI " + uri.toString());
      List<dynamic> data = await HttpHelper.invokeHttp(uri, RequestType.get);
      dynamic response =  data.map((e) => ProductEntity().fromJson(e)).toList();
      return response;
    }catch(e){
      print(e);
      rethrow;
    }
  }

}