import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/home/home_entity.dart';
import 'package:coupon_app/domain/repositories/home_repository.dart';
import 'package:logging/logging.dart';
class DataHomeRepository extends HomeRepository{

  static DataHomeRepository instance = DataHomeRepository._internal();

  Logger _logger;

  DataHomeRepository._internal(){
    _logger = Logger("DataHomeRepository");
  }

  factory DataHomeRepository() => instance;


  @override
  Future<HomeEntity> getHomePage() async{
     try{
       //TODO language and country filter
       dynamic data = await HttpHelper.invokeHttp("${Constants.home}?country=1&lang=1", RequestType.get);
       print("-----------> ${data}");
       return HomeEntity().fromJsonMapper(data);
     }catch(e){
       _logger.finest(e);
       rethrow;
     }
  }

}