import 'dart:async';

import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:meta/meta.dart';

class LoginWithGoogleUsecase extends CompletableUseCase<GLoginParams>{
  final AuthenticationRepository _repository;

  LoginWithGoogleUsecase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(GLoginParams params) async {
    final StreamController<Customer> controller = StreamController();
    try {
      Customer userEntity  = await _repository.authenticateGoogle(
          accessToken: params.accessToken);
      controller.add(userEntity);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }

}

class GLoginParams {
  String accessToken;
  GLoginParams({this.accessToken});
}