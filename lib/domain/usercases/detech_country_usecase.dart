import 'dart:async';

import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/ipdetect/IPDetectResponse.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class DetectCountryUseCase extends CompletableUseCase<void>{
  final CountryRepository _repository;


  DetectCountryUseCase(this._repository);

  @override
  Future<Stream<IPDetectResponse>> buildUseCaseStream(void params) async {
    StreamController<IPDetectResponse> controller = new StreamController();
    try{
      IPDetectResponse countries = await _repository.detectCountry();
      Logger().e("Detect ${countries}");
      controller.add(countries);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }

}