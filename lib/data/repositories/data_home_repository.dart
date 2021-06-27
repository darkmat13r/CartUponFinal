import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/models/HomeData.dart';
import 'package:coupon_app/domain/repositories/home_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:logging/logging.dart';
class DataHomeRepository extends HomeRepository{

  static DataHomeRepository instance = DataHomeRepository._internal();

  Logger _logger;

  DataHomeRepository._internal(){
    _logger = Logger("DataHomeRepository");
  }

  factory DataHomeRepository() => instance;


  @override
  Future<HomeData> getHomePage() async{
     try{

       var uri = Constants.createUriWithParams(Constants.homeRoute, {
         'country' : (await SessionHelper().getSelectedCountryId()).toString(),
         'lang' : Config().getLanguageId().toString()
       });
      dynamic data = await HttpHelper.invokeHttp(uri, RequestType.get);
       var result =  HomeData.fromJson(data);
       print("-----------> ${result}");
       return result;
     }catch(e){
       _logger.finest(e);
       rethrow;
     }
  }

}