import 'package:coupon_app/domain/entities/models/VerificationResponse.dart';

abstract class VerificationRepository{
  Future<dynamic> requestOtp({String countryCode, int countryId, String mobileNumber});
  Future<VerificationResponse> verifyOtp({String countryCode,int countryId, String mobileNumber, String otp});
}