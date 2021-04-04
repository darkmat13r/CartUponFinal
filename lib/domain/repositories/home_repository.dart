import 'package:coupon_app/domain/entities/home/home_entity.dart';

abstract class HomeRepository {
  Future<HomeEntity> getHomePage();
}