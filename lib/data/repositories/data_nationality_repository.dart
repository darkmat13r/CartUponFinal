import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/models/Nationality.dart';
import 'package:coupon_app/domain/repositories/nationality_repository.dart';
import 'package:logger/logger.dart';

class DataNationalityRepository extends NationalityRepository{
  static DataNationalityRepository _instance =
  DataNationalityRepository._internal();
  Logger _logger;

  // Constructors
  DataNationalityRepository._internal() {
    _logger = Logger();
  }

  factory DataNationalityRepository() => _instance;

  @override
  Future<List<Nationality>> getNationalities() async {
    try{

      List<dynamic> data = await HttpHelper.invokeHttp(Constants.nationalityRoute, RequestType.get);
      dynamic response = data.map((e) => Nationality.fromJson(e)).toList();
      return response;
    }catch(e){
      _logger.e(e);
      rethrow;
    }
  }

}