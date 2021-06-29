import 'package:coupon_app/domain/entities/models/VerificationResponse.dart';

abstract class VerificationRepository{
  Future<dynamic> requestOtp({String countryCode, String mobileNumber});
  Future<VerificationResponse> verifyOtp({String countryCode, String mobileNumber, String otp});
}