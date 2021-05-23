import 'package:coupon_app/domain/entities/models/Country.dart';

abstract class CountryRepository{
  Future<List<Country>> getCountries();
}