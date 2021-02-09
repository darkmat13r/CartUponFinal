import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
import 'package:coupon_app/domain/entities/user_entity.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';

/// A `UseCase` for logging in a `User` into the application
class LoginUseCase extends CompletableUseCase<LoginUseCaseParams> {
  // Members
  AuthenticationRepository _authenticationRepository;
  Logger _logger;
  // Constructors
  LoginUseCase(this._authenticationRepository) : super() {
    _logger = Logger('LoginUseCase');
  }

  @override
  Future<Stream<UserEntity>> buildUseCaseStream(LoginUseCaseParams params) async {
    final StreamController<UserEntity> controller = StreamController();
    try {
      UserEntity userEntity  = await _authenticationRepository.authenticate(
          email: params._email, password: params._password);
      controller.add(userEntity);
      controller.close();
    } catch (e) {

      controller.addError(e);
      _logger.shout('Could not login the user.', e.message);
    }
    return controller.stream;
  }
}

/// The parameters required for the [LoginUseCase]
class LoginUseCaseParams {
  String _email;
  String _password;

  LoginUseCaseParams(this._email, this._password);
}
