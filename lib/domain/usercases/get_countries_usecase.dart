import 'dart:async';

import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetCountriesUseCase extends CompletableUseCase<void>{
  final CountryRepository _repository;


  GetCountriesUseCase(this._repository);

  @override
  Future<Stream<List<Country>>> buildUseCaseStream(void params) async {
    StreamController<List<Country>> controller = new StreamController();
    try{
      List<Country> countries = await _repository.getCountries();
      controller.add(countries);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }

}