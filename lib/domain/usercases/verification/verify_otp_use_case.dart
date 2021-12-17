import 'dart:async';

import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/VerificationResponse.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/repositories/verification_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class VerifyOtpUseCase extends CompletableUseCase<VerifyOtpParams>{
  final VerificationRepository _repository;


  VerifyOtpUseCase(this._repository);

  @override
  Future<Stream<VerificationResponse>> buildUseCaseStream(VerifyOtpParams params) async {
    StreamController<VerificationResponse> controller = new StreamController();
    try{
      dynamic response = await _repository.verifyOtp(countryId : params.countryId, countryCode  : params.countryCode, mobileNumber : params.mobileNumber , otp : params.otp);
      controller.add(response);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }

}

class VerifyOtpParams{
  String mobileNumber;
  String otp;
  String countryCode;
  int countryId;

  VerifyOtpParams({this.mobileNumber, this.otp, this.countryCode, this.countryId});
}