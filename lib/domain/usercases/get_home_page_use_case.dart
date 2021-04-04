import 'dart:async';

import 'package:coupon_app/domain/entities/home/home_entity.dart';
import 'package:coupon_app/domain/repositories/home_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

class GetHomePageUseCase extends CompletableUseCase<void>{

  Logger _logger;

  HomeRepository _homeRepository;

  GetHomePageUseCase(this._homeRepository){
    _logger = Logger('GetHomePageUseCase');
  }

  @override
  Future<Stream<HomeEntity>> buildUseCaseStream(void params) async{
    final StreamController<HomeEntity> controller  = new StreamController();
    try{
      HomeEntity data = await _homeRepository.getHomePage();
      controller.add(data);
    }catch(e){
      _logger.finest(e);
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }

}