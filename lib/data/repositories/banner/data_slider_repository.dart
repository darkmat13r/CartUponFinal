import 'dart:collection';

import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/slider_banner_entity.dart';
import 'package:coupon_app/domain/repositories/banners/slider_repository.dart';
import 'package:logging/logging.dart';
class DataSliderRepository extends SliderRepository{

  static DataSliderRepository _instance =  DataSliderRepository._internal();

  Logger _logger;

  DataSliderRepository._internal(){
    _logger = Logger("DataSliderBannerRepository");
  }

  factory DataSliderRepository() => _instance;


  @override
  Future<List<SliderBannerEntity>> getAllBanners() async{
    try{
      _logger.finest("Data getAllBanners");
      List<dynamic> data = await HttpHelper.invokeHttp(Constants.sliders, RequestType.get);
      _logger.finest("Data ", data);
       dynamic response = data.map((e) => SliderBannerEntity().fromJson(e)).toList();
      _logger.finest("Response ", data);

      return response;
    }catch(error){
      print( error.stackTrace.toString());
      _logger.warning('Couldn\'t fetch sliders', error);
      rethrow;
    }
  }


}