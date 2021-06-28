import 'dart:async';

import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:coupon_app/domain/entities/user_entity.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';

class GetUserProfileUseCase extends UseCase<Customer, void>{
  AuthenticationRepository _authenticationRepository;
  GetUserProfileUseCase(this._authenticationRepository);
  @override
  Future<Stream<Customer>> buildUseCaseStream(params) async {
    final StreamController<Customer> controller = StreamController();
    try {
      Customer  user = await _authenticationRepository.getProfile();
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