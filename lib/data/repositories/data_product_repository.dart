import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
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
  Future<List<ProductDetail>> getProducts({String categoryId, String country}) async{
    try{
      var uri = Constants.createUriWithParams(Constants.products, {
        'category' : categoryId,
        'lang' :  Config().getLanguageId().toString()
      });
      List<dynamic> data = await HttpHelper.invokeHttp(uri, RequestType.get);
      dynamic response =  data.map((e) => ProductDetail.fromJson(e)).toList();
      return response;
    }catch(e){
      print(e);
      rethrow;
    }
  }

  @override
  Future<ProductDetail> getById(String productId) async{
    try{
      Map<String, dynamic>  data = await HttpHelper.invokeHttp("${Constants.products}$productId", RequestType.get);
      ProductDetail  product = ProductDetail.fromJson(data);
      return product;
    }catch(e){
      print(e);
      rethrow;
    }
  }

}