import 'package:coupon_app/domain/entities/models/VerificationResponse.dart';

abstract class VerificationRepository{
  Future<dynamic> requestOtp(String mobileNumber);
  Future<VerificationResponse> verifyOtp(String mobileNumber, String otp);
}