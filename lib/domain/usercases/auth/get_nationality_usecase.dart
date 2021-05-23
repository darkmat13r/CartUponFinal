import 'dart:async';

import 'package:coupon_app/domain/entities/models/Nationality.dart';
import 'package:coupon_app/domain/repositories/nationality_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetNationalitiesUseCase extends CompletableUseCase<void>{
  NationalityRepository _repository;


  GetNationalitiesUseCase(this._repository);

  @override
  Future<Stream<List<Nationality>>> buildUseCaseStream(void params) async {
    final StreamController<List<Nationality>> controller = new StreamController();
    try{
      List<Nationality> nationalities = await _repository.getNationalities();
      controller.add(nationalities);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }

}