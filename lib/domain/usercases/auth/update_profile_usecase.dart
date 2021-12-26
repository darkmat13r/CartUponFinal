import 'dart:async';

import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

class UpdateProfileUseCase extends CompletableUseCase<UpdateProfileParams> {

  AuthenticationRepository authRepo;

  Logger _logger;

  UpdateProfileUseCase(this.authRepo) {
    _logger = Logger("RegisterUseCase");
  }

  @override
  Future<Stream<void>> buildUseCaseStream(UpdateProfileParams params) async {
    StreamController<Customer> controller = StreamController();
    try {
      Customer user = await authRepo.update(firstName: params.firstName,
          lastName: params.lastName,
          username: params.email,
          email: params.email,
          country: params.country,
          countryCode: params.countryCode,
          mobileNo: params.mobileNo,
          nationality: params.nationality.toString(),
          gender: params.gender.toString(),
          title: params.title.toString(),
          dateOfBirth: params.dateOfBirth,
          isActive: "1");
      controller.add(user);
      controller.close();
    } catch (e) {
      _logger.shout(e);
      controller.addError(e);
    }

    return controller.stream;
  }

}


class UpdateProfileParams {
  String firstName;
  String lastName;
  String email;
  String countryCode;
  String mobileNo;
  int country;
  String dateOfBirth;
  int nationality;
  int gender;
  int title;

  UpdateProfileParams(
      {@required this.firstName, @required this.lastName, @required this.email, @required this.countryCode,
        @required this.nationality,
        @required this.gender,
        @required this.title,
        @required this.country,
      @required this.mobileNo, @required this.dateOfBirth});
}