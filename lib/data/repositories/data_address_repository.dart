import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:logging/logging.dart';

class DataAddressRepository extends AddressRepository {
  static DataAddressRepository _instance = DataAddressRepository._internal();
  Logger _logger;

  DataAddressRepository._internal() {
    _logger = Logger("DataAddressRepository");
  }

  factory DataAddressRepository() => _instance;

  @override
  Future<void> delete(String id) async {
    try {
      await HttpHelper.invokeHttp(
          "${Constants.addressRoute}/${id}", RequestType.delete);
    } catch (e) {
      _logger.shout(e);
      rethrow;
    }
  }

  @override
  Future<List<Address>> getAddresses() async {
    try {
      Token token = await SessionHelper().getCurrentUser();
      var url = Constants.createUriWithParams(
          "${Constants.addressRoute}", {'user_id': token.user.id.toString()});
      List<dynamic> addressesData =
          await HttpHelper.invokeHttp2(url, RequestType.get);
      List<Address> addresses =
          addressesData.map((e) => Address.fromJson(e)).toList();
      return addresses;
    } catch (e) {
      _logger.shout(e);
      rethrow;
    }
  }

  @override
  Future<Address> saveAddress(
      {String area,
      String block,
      String building,
      String floorFlat,
      String address,
      bool isDefault,
      String phoneNo}) async {
    try {
      Token token = await SessionHelper().getCurrentUser();

      Map<String, dynamic> data = await HttpHelper.invokeHttp(
          "${Constants.addressRoute}", RequestType.post,
          body: {
            'user': token.user.id,
            'area': area,
            'block': block,
            'building': building,
            'floor_flat': floorFlat,
            'address': address,
            'phone': phoneNo,
            'is_default': isDefault
          });
      Address addressObj = Address.fromJson(data);
      return addressObj;
    } catch (e) {
      _logger.shout(e);
      rethrow;
    }
  }

  @override
  Future<Address> updateAddress(String id,
      {String area,
      String block,
      String building,
      String floorFlat,
      String address,
      bool isDefault,
      String phoneNo}) async {
    try {
      Map<String, dynamic> data = await HttpHelper.invokeHttp(
          "${Constants.addressRoute}/${id}", RequestType.put,
          body: {
            'area': area,
            'block': block,
            'building': building,
            'floor_flat': floorFlat,
            'address': address,
            'phone': phoneNo,
            'is_default': isDefault
          });
      Address addressObj = Address.fromJson(data);
      return addressObj;
    } catch (e) {
      _logger.shout(e);
      rethrow;
    }
  }
}
