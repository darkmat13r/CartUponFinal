import 'package:coupon_app/domain/entities/location.dart';
import 'package:coupon_app/domain/repositories/local_repository.dart';
import 'package:location/location.dart' as LocationLib;

class DeviceLocationRepository extends LocationRepository {

  static final DeviceLocationRepository _instance = DeviceLocationRepository
      ._internal();
  final LocationLib.Location _locationDevice;
  LocationLib.PermissionStatus _permissionStatus;


  DeviceLocationRepository._internal()
      : _locationDevice = LocationLib.Location();


  factory DeviceLocationRepository() => _instance;

  @override
  void enableDevice() async{
    bool enabled = await _locationDevice.serviceEnabled();
    _permissionStatus = await _locationDevice.hasPermission();
    if(!enabled){
      await _locationDevice.requestService();
    }
    if(_permissionStatus != LocationLib.PermissionStatus.granted){
      await _locationDevice.requestPermission();
    }
  }

  @override
  Future<Location> getLocation() async{
    try {
      LocationLib.LocationData location = await _locationDevice.getLocation();
      return Location.withoutTime(location.latitude.toString(),
          location.longitude.toString(), location.speed);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<LocationLib.LocationData> onLocationChanged() => _locationDevice.onLocationChanged;

}