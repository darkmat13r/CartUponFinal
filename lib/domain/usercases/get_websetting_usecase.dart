import 'dart:async';

import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/WebSetting.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/repositories/home_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetWebSettingsUseCase extends CompletableUseCase<void>{
  final HomeRepository _repository;


  GetWebSettingsUseCase(this._repository);

  @override
  Future<Stream<WebSetting>> buildUseCaseStream(void params) async {
    StreamController<WebSetting> controller = new StreamController();
    try{
      WebSetting webSetting = await _repository.getWebSettings();
      controller.add(webSetting);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }

}