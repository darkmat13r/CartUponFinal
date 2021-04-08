import 'dart:async';

import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class UpdateProfileUseCase extends CompletableUseCase<UpdateProfileParams>{

  AuthenticationRepository authRepo;

  Logger _logger;

  UpdateProfileUseCase(this.authRepo){
    _logger = Logger("RegisterUseCase");
  }

  @override
  Future<Stream<void>> buildUseCaseStream(UpdateProfileParams params) async{
    StreamController<Token> controller  = StreamController();
    try{
      Token user = await authRepo.update(firstName: params.firstName, lastName: params.lastName,
          username: params.email, email: params.email, countryCode: params.countryCode,
          mobileNo: params.mobileNo, dateOfBirth: params.dateOfBirth, isActive: "1");
      controller.add(user);
    }catch(e){
      _logger.shout(e);
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }

}



class UpdateProfileParams{
  String firstName;
  String lastName;
  String email;
  String countryCode;
  String mobileNo;
  String dateOfBirth;

  UpdateProfileParams({@required this.firstName,@required this.lastName,@required this.email,@required this.countryCode,
    @required this.mobileNo,@required this.dateOfBirth});
}