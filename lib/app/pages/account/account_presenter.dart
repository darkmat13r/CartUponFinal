import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/usercases/auth/get_current_user_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AccountPresenter extends AuthPresenter{
  AccountPresenter(AuthenticationRepository authRepo) : super(authRepo);




  @override
  void dispose() {

  }
}