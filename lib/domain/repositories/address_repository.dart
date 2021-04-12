import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/Area.dart';
import 'package:coupon_app/domain/entities/models/Block.dart';
import 'package:flutter/cupertino.dart';

abstract class AddressRepository {


  Future<List<Area>>  getAreas();
  Future<List<Block>> getBlocks(String areaId);

  Future<Address> saveAddress(
      {
      @required String firstName,
      @required String lastName,
      @required Area area,
      @required Block block,
      @required String building,
      @required String floorFlat,
      @required String address,
        @required bool isDefault,
      @required String phoneNo});

  Future<List<Address>> getAddresses();

  Future<Address> updateAddress(String id,
      {
        @required String firstName,
        @required String lastName,
        @required Area area,
      @required Block block,
      @required String building,
      @required String floorFlat,
      @required String address,
      @required bool isDefault,
      @required String phoneNo});

  Future<void> delete(String id);
}
