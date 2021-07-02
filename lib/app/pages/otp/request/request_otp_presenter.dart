import 'package:coupon_app/app/pages/otp/verify/verify_otp_presenter.dart';
import 'package:coupon_app/domain/repositories/verification_repository.dart';
import 'package:coupon_app/domain/usercases/verification/request_otp_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class RequestOtpPresenter extends VerifyOtpPresenter{

  RequestOtpPresenter(VerificationRepository verificationRepository) : super(verificationRepository) ;



  @override
  void dispose() {

  }

}

