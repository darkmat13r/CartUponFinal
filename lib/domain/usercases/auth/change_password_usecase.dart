import 'dart:async';

import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class ChangePasswordUseCase extends CompletableUseCase<ChangePasswordParams>{

  AuthenticationRepository authRepo;

  Logger _logger;

  ChangePasswordUseCase(this.authRepo){
    _logger = Logger("RegisterUseCase");
  }

  @override
  Future<Stream<void>> buildUseCaseStream(ChangePasswordParams params) async{
    StreamController<void> controller  = StreamController();
    try{
      await authRepo.updatePassword(current : params.currentPassword, password: params.newPassword, passwordRepeat: params.confirmPassword);
      controller.close();
    }catch(e){
      _logger.shout(e);
      controller.addError(e);
    }

    return controller.stream;
  }

}

class ChangePasswordParams{
  String currentPassword;
  String newPassword;
  String confirmPassword;

  ChangePasswordParams(this.currentPassword, this.newPassword, this.confirmPassword);
}



