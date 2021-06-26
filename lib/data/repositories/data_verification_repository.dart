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
  Future requestOtp(String mobileNumber) async {
    var params = {'mobileno': mobileNumber};
    try {
      dynamic data =
          await HttpHelper.invokeHttp(Constants.sendOtp, RequestType.post, body: params);

      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<VerificationResponse> verifyOtp(String mobileNumber, String otp) async{
    var params = {'mobileno': mobileNumber, 'otpno' : otp};
    try {
      dynamic data =
          await HttpHelper.invokeHttp(Constants.validateOtp, RequestType.post, body: params);
      VerificationResponse response = VerificationResponse.fromJson(data);
      return response;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}
