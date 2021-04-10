import 'dart:async';

import 'package:coupon_app/domain/entities/models/HomeData.dart';
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
  Future<Stream<HomeData>> buildUseCaseStream(void params) async{
    final StreamController<HomeData> controller  = new StreamController();
    try{
      HomeData data = await _homeRepository.getHomePage();
      controller.add(data);
      controller.close();
    }catch(e){
      _logger.finest(e);
      controller.addError(e);
    }

    return controller.stream;
  }

}