import 'package:coupon_app/domain/entities/models/Nationality.dart';

abstract class NationalityRepository{
  Future<List<Nationality>> getNationalities();
}