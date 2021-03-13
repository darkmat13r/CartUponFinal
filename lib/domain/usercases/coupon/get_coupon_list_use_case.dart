import 'dart:async';

import 'package:coupon_app/domain/entities/coupons/coupon_entity.dart';
import 'package:coupon_app/domain/repositories/coupon/coupon_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetCouponListUseCase extends CompletableUseCase<CouponFilterParams>{

  CouponRepository _couponRepository;


  GetCouponListUseCase(this._couponRepository);

  @override
  Future<Stream<List<CouponEntity>>> buildUseCaseStream(CouponFilterParams params) async{
    StreamController<List<CouponEntity>> controller = new StreamController();
    try{
      List<CouponEntity> coupons = await _couponRepository.getCoupons(categoryId: params.categoryId);
      controller.add(coupons);
    }catch(e){
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }

}


class CouponFilterParams{
  String categoryId;

  CouponFilterParams({this.categoryId});
}