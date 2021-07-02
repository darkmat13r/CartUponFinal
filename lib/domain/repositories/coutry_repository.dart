import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/ipdetect/IPDetectResponse.dart';

abstract class CountryRepository{
  Future<List<Country>> getCountries();

  Future<IPDetectResponse> detectCountry();
}