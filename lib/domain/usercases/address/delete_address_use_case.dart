import 'dart:async';

import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class DeleteAddressUseCase extends  CompletableUseCase<String>{

  AddressRepository _repository;

  Logger _logger;

  DeleteAddressUseCase(this._repository){
    _logger = Logger("DeleteAddressUseCase");
  }
  @override
  Future<Stream<void>> buildUseCaseStream(String params) async{
    StreamController<void> controller = StreamController();
    try{
      var data = await _repository.delete(params);
      controller.add(data);
      controller.close();
    }catch(e){
      controller.addError(e);
    }

    return controller.stream;
  }


}