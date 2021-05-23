import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/domain/repositories/home_repository.dart';
import 'package:coupon_app/domain/usercases/get_home_page_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomePresenter extends AuthPresenter{



  HomePresenter(authRepo) :super(authRepo) {

  }

  @override
  void dispose() {

  }
}