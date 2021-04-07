import 'dart:async';

import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class GetAddressesUseCase extends CompletableUseCase<void>{

  AddressRepository _repository;

  Logger _logger;

  GetAddressesUseCase(this._repository){
    _logger = Logger("GetAddressesUseCase");
  }

  @override
  Future<Stream<List<Address>>> buildUseCaseStream(void params) async {
    StreamController<List<Address>> controller = StreamController();
   try{
     List<Address> addresses = await _repository.getAddresses();
     controller.add(addresses);
   }catch(e){
     controller.addError(e);

   }
   controller.close();
   return controller.stream;
  }



}
