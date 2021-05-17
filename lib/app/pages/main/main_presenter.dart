import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class MainPresenter extends AuthPresenter{
  MainPresenter(AuthenticationRepository authRepo) : super(authRepo);

  @override
  void dispose() {
  }

}