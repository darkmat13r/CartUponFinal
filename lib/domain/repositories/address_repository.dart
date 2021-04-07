import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:flutter/cupertino.dart';

abstract class AddressRepository {
  Future<Address> saveAddress(
      {
      @required String area,
      @required String block,
      @required String building,
      @required String floorFlat,
      @required String address,
        @required bool isDefault,
      @required String phoneNo});

  Future<List<Address>> getAddresses();

  Future<Address> updateAddress(String id,
      {@required String area,
      @required String block,
      @required String building,
      @required String floorFlat,
      @required String address,
      @required bool isDefault,
      @required String phoneNo});

  Future<void> delete(String id);
}
