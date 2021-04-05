import 'package:coupon_app/domain/entities/models/HomeData.dart';

abstract class HomeRepository {
  Future<HomeData> getHomePage();
}