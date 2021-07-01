import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/ipdetect/IPDetectResponse.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:logger/logger.dart';

class DataCountryRepository extends CountryRepository {
  static DataCountryRepository instance = DataCountryRepository._internal();

  Logger _logger;

  DataCountryRepository._internal() {
    _logger = Logger();
  }

  factory DataCountryRepository() => instance;

  @override
  Future<List<Country>> getCountries() async {
    List<Country> countries = await SessionHelper().cachedCounties();
    try {
      List<dynamic> response = await HttpHelper.invokeHttp(
          Constants.countriesRoute, RequestType.get);
      countries = response.map((e) => Country.fromJson(e)).toList();
      SessionHelper().cacheCounties(countries);
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
    return countries;
  }

  @override
  Future<IPDetectResponse> detectCountry() async {
    try {
      final ipv4 = await Ipify.ipv4();
      var detechIp = await HttpHelper.invokeHttp(
          "${Constants.ipDetechApi}/$ipv4", RequestType.get);
      _logger.e("Respinse ${detechIp}");
      IPDetectResponse ipDetect = IPDetectResponse.fromJson(detechIp);
      return ipDetect;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}
