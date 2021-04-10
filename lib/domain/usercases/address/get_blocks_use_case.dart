import 'dart:async';

import 'package:coupon_app/domain/entities/models/Area.dart';
import 'package:coupon_app/domain/entities/models/Block.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class GetBlocksUseCase extends CompletableUseCase<String>{
  AddressRepository addressRepository;

  Logger _logger;


  GetBlocksUseCase(this.addressRepository){
    _logger = Logger("GetBlocksUseCase");
  }

  @override
  Future<Stream<List<Block>>> buildUseCaseStream(String areaId) async{
    final StreamController<List<Block>> controller = StreamController();
    try{
      List<Block> blocks = await addressRepository.getBlocks(areaId);
      controller.add(blocks);
      controller.close();
    }catch(e){
      controller.addError(e);
    }

    return controller.stream;
  }


}