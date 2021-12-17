import 'package:coupon_app/domain/repositories/verification_repository.dart';
import 'package:coupon_app/domain/usercases/verification/request_otp_use_case.dart';
import 'package:coupon_app/domain/usercases/verification/verify_otp_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class VerifyOtpPresenter extends Presenter {
  final VerifyOtpUseCase _verifyOtpUseCase;
  Function verifyOtpOnComplete;
  Function verifyOtpOnError;
  Function verifyOtpOnNext;

  final RequestOtpUseCase _requestOtpUseCase;
  Function requestOtpOnComplete;
  Function requestOtpOnError;
  Function requestOtpOnNext;

  VerifyOtpPresenter(VerificationRepository verificationRepository)
      : _verifyOtpUseCase = VerifyOtpUseCase(verificationRepository),
        _requestOtpUseCase = RequestOtpUseCase(verificationRepository);

  requestOtp({String mobileNumber, String countryCode, int countryId}) {
    _requestOtpUseCase.execute(_RequestOtpObserver(this),
        RequestOtpParams(mobileNumber: mobileNumber,countryId: countryId, countryCode: countryCode));
  }

  @override
  void dispose() {
    _verifyOtpUseCase.dispose();
    _requestOtpUseCase.dispose();
  }

  void verifyOtp({String mobileNumber, String countryCode,int countryId, String text}) {
    _verifyOtpUseCase.execute(
        _VerifyOtpObserver(this), VerifyOtpParams(mobileNumber: mobileNumber, countryId : countryId, countryCode: countryCode, otp: text));
  }
}

class _VerifyOtpObserver extends Observer<dynamic> {
  final VerifyOtpPresenter _presenter;

  _VerifyOtpObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.verifyOtpOnComplete != null);
    _presenter.verifyOtpOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.verifyOtpOnError != null);
    _presenter.verifyOtpOnError(e);
  }

  @override
  void onNext(response) {
    assert(_presenter.verifyOtpOnNext != null);
    _presenter.verifyOtpOnNext(response);
  }
}

class _RequestOtpObserver extends Observer<dynamic> {
  final VerifyOtpPresenter _presenter;

  _RequestOtpObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.requestOtpOnComplete != null);
    _presenter.requestOtpOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.requestOtpOnError != null);
    _presenter.requestOtpOnError(e);
  }

  @override
  void onNext(response) {
    assert(_presenter.requestOtpOnNext != null);
    _presenter.requestOtpOnNext(response);
  }
}
