import 'dart:async';

import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:coupon_app/domain/entities/user_entity.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';

class GetCurrentUserUseCase extends UseCase<Token, void>{
  AuthenticationRepository _authenticationRepository;
  GetCurrentUserUseCase(this._authenticationRepository);
  @override
  Future<Stream<Token>> buildUseCaseStream(params) async {
    final StreamController<Token> controller = StreamController();
    try {
      Token  user = await _authenticationRepository.getCurrentUser();
      logger.finest('GetAuthStatusUseCase successful. ${user}');
      controller.add(user);
      logger.finest('GetAuthStatusUseCase successful.');
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('GetAuthStatusUseCase unsuccessful.');
      controller.addError(e);
    }
    return controller.stream;
  }

}