import 'dart:async';

import 'package:coupon_app/domain/entities/models/Area.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class GetAreasUseCase extends CompletableUseCase<void>{
  AddressRepository addressRepository;

  Logger _logger;


  GetAreasUseCase(this.addressRepository){
    _logger = Logger("GetAreasUseCase");
  }

  @override
  Future<Stream<List<Area>>> buildUseCaseStream(void params) async{
    final StreamController<List<Area>> controller = StreamController();
    try{
      List<Area> areas = await addressRepository.getAreas();
      controller.add(areas);
    }catch(e){
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }


}