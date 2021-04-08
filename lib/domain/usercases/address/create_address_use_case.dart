import 'dart:async';

import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class CreateAddressUseCase extends CompletableUseCase<Address>{
  AddressRepository _repository;

  Logger _logger;

  CreateAddressUseCase(this._repository) {
    _logger = Logger("CreateAddressUseCase");
  }

  @override
  Future<Stream<Address>> buildUseCaseStream(Address params) async {
    StreamController<Address> controller = StreamController();
    try {
      var data = await _repository.saveAddress(
          firstName: params.first_name,
          lastName: params.last_name,
          area: params.area,
          address: params.address,
          phoneNo: params.phone_no,
          floorFlat: params.floor_flat,
          isDefault: params.is_default,
          building: params.building,
          block: params.block);
      controller.add(data);
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }


}