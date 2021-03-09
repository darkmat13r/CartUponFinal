import 'dart:async';

import 'package:coupon_app/domain/repositories/banners/slider_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
import 'package:coupon_app/domain/entities/slider_banner_entity.dart';

class GetSlidersUseCase extends CompletableUseCase<void>{

  SliderRepository _sliderRepository;

  Logger _logger;


  GetSlidersUseCase(this._sliderRepository):super(){
    _logger = Logger("GetSlidersUseCase");
  }

  @override
  Future<Stream<List<SliderBannerEntity>>> buildUseCaseStream(void params) async{
    final StreamController<List<SliderBannerEntity>> controller = StreamController();
    try{
      List<SliderBannerEntity> sliders = await _sliderRepository.getAllBanners();
      controller.add(sliders);
      controller.close();
    }catch(e){


      controller.addError(e);
      _logger.shout('Couldn\'t load sliders', e);
    }
    return controller.stream;
  }

}