import 'package:coupon_app/domain/entities/models/HomeData.dart';
import 'package:coupon_app/domain/entities/models/WebSetting.dart';

abstract class HomeRepository {
  Future<HomeData> getHomePage();
  Future<WebSetting> getWebSettings();
}