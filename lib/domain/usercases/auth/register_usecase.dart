import 'dart:async';
import 'dart:convert';

import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart';

class RegisterUseCase extends CompletableUseCase<RegisterParams> {
  AuthenticationRepository authRepo;

  Logger _logger;

  RegisterUseCase(this.authRepo) {
    _logger = Logger("RegisterUseCase");
  }

  @override
  Future<Stream<Customer>> buildUseCaseStream(RegisterParams params) async {
    StreamController<Customer> controller = StreamController();
    try {
      Customer user = await authRepo.register(
          firstName: params.firstName,
          lastName: params.lastName,
          username: params.email,
          email: params.email,
          countryCode: params.countryCode,
          mobileNo: params.mobileNo,
          dateOfBirth: params.dateOfBirth,
          isActive: "1",
          nationality: params.nationality.toString(),
          gender: params.gender.toString(),
          title: params.title.toString(),
          password: params.password);
      controller.add(user);
    } catch (e) {
      _logger.shout(e);
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}

class RegisterParams {
  String firstName;
  String lastName;
  String email;
  String countryCode;
  String mobileNo;
  String dateOfBirth;
  int nationality;
  int gender;
  int title;
  String password;

  RegisterParams(
      {@required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.countryCode,
      @required this.mobileNo,
      @required this.dateOfBirth,
      @required this.password,
      @required this.nationality,
      @required this.gender,
      @required this.title,
      });
}
