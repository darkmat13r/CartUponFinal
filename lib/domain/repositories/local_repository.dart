import 'dart:async';

import 'package:location/location.dart' as lib;
import 'package:coupon_app/domain/entities/location.dart';
abstract class LocationRepository{
  Future<Location> getLocation();
  Stream<lib.LocationData> onLocationChanged();
  void enableDevice();
}