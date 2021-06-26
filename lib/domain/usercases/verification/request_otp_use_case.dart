import 'dart:async';

import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/repositories/verification_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class RequestOtpUseCase extends CompletableUseCase<String>{
  final VerificationRepository _repository;


  RequestOtpUseCase(this._repository);

  @override
  Future<Stream<dynamic>> buildUseCaseStream(String mobileNumber) async {
    StreamController<dynamic> controller = new StreamController();
    try{
      dynamic response = await _repository.requestOtp(mobileNumber);
      controller.add(response);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }

}