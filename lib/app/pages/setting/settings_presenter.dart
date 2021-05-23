import 'package:coupon_app/app/pages/splash/splash_presenter.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/usercases/get_countries_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SettingsPresenter extends SplashPresenter{

  SettingsPresenter(CountryRepository repository) : super(repository);

  @override
  void dispose() {
    super.dispose();
  }

}
