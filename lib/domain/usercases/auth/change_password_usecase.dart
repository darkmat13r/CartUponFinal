import 'dart:async';

import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class ChangePasswordUseCase extends CompletableUseCase<String>{

  AuthenticationRepository authRepo;

  Logger _logger;

  ChangePasswordUseCase(this.authRepo){
    _logger = Logger("RegisterUseCase");
  }

  @override
  Future<Stream<void>> buildUseCaseStream(String params) async{
    StreamController<void> controller  = StreamController();
    try{
      await authRepo.updatePassword(password: params);
      controller.close();
    }catch(e){
      _logger.shout(e);
      controller.addError(e);
    }

    return controller.stream;
  }

}



