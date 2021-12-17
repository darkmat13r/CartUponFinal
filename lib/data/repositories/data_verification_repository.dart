import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/models/VerificationResponse.dart';
import 'package:coupon_app/domain/repositories/verification_repository.dart';
import 'package:logger/logger.dart';

class DataVerificationRepository extends VerificationRepository {
  static DataVerificationRepository instance =
      DataVerificationRepository._internal();

  Logger _logger;

  DataVerificationRepository._internal() {
    _logger = Logger();
  }

  factory DataVerificationRepository() => instance;

  @override
  Future requestOtp({String mobileNumber, String countryCode, int countryId}) async {
    var params = {'mobileno': mobileNumber, 'country_code' : countryCode, 'country' : countryId.toString()};
    try {
      dynamic data =
          await HttpHelper.invokeHttp(Constants.sendOtpRoute, RequestType.post, body: params);

      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<VerificationResponse> verifyOtp({String mobileNumber, String otp,  String countryCode, int countryId}) async{
    var params = {'mobileno': mobileNumber, 'otpno' : otp,  'country_code' : countryCode, 'country' : countryId.toString()};
    try {
      dynamic data =
          await HttpHelper.invokeHttp(Constants.validateOtpRoute, RequestType.post, body: params);
      VerificationResponse response = VerificationResponse.fromJson(data);
      return response;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}
