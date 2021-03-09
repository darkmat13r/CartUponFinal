import 'package:coupon_app/domain/entities/slider_banner_entity.dart';
abstract class SliderRepository{
  Future<List<SliderBannerEntity>> getAllBanners();
}