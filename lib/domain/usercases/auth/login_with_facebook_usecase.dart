import 'dart:async';

import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class LoginWithFacebookUsecase extends CompletableUseCase<FbLoginParams>{
  final AuthenticationRepository _repository;


  LoginWithFacebookUsecase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(FbLoginParams params) async {
    final StreamController<Token> controller = StreamController();
    try {
      Token userEntity  = await _repository.authenticateFacebook(
          accessToken: params.accessToken);
      controller.add(userEntity);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }

}


class FbLoginParams{
  String accessToken;

  FbLoginParams({this.accessToken});

}