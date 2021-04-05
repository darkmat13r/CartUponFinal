import 'package:coupon_app/domain/entities/models/BannerSlider.dart';
abstract class SliderRepository{
  Future<List<BannerSlider>> getAllBanners();
}