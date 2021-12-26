import 'dart:async';

import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

class ForgotPasswordUseCase extends UseCase<void, ForgotPasswordUseCaseParams>{
  // Members
  AuthenticationRepository _authenticationRepository;
  Logger _logger;
  // Constructors
  ForgotPasswordUseCase(this._authenticationRepository) : super() {
    _logger = Logger('ForgotPasswordUseCase');
  }
  @override
  Future<Stream<void>> buildUseCaseStream(ForgotPasswordUseCaseParams params) async{
    final StreamController<void> controller = StreamController();
    try {
      await _authenticationRepository.forgotPassword(
         params._email);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }

}
/// The parameters required for the [LoginUseCase]
class ForgotPasswordUseCaseParams {
  String _email;

  ForgotPasswordUseCaseParams(this._email);
}