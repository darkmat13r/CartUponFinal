import 'dart:async';

import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

class UpdateAddressUseCase extends CompletableUseCase<Address> {
  AddressRepository _repository;

  Logger _logger;

  UpdateAddressUseCase(this._repository) {
    _logger = Logger("UpdateAddressUseCase");
  }

  @override
  Future<Stream<Address>> buildUseCaseStream(Address params) async {
    StreamController<Address> controller = StreamController();
    try {
      var data = await _repository.updateAddress(params.id.toString(),
          area: params.area,
          address: params.address,
          phoneNo: params.phone_no,
          floorFlat: params.floor_flat,
          isDefault: params.is_default,
          building: params.building,
          block: params.block);
      controller.add(data);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}
