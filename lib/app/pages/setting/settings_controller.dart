import 'package:coupon_app/app/pages/splash/splash_controller.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/repositories/home_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:logger/logger.dart';
import 'package:devicelocale/devicelocale.dart';

class SettingsController extends SplashController {
  SettingsController(CountryRepository repo, HomeRepository _homeRepo) : super(repo, _homeRepo) {
    newSelectedCountry = Config().selectedCountry;
    getLanguageCode();
  }

  Country newSelectedCountry;
  String languageCode = "en";

  @override
  home() {}

  @override
  void onLoadCountries() async {
    super.onLoadCountries();
    refreshUI();
  }

  void setSelectedCountry(Country country) {
    newSelectedCountry = country;
    refreshUI();
  }

  void setLanguage(languageCode) {
    this.languageCode = languageCode;
    refreshUI();
  }

  void save(context) async{
    languageCode = languageCode != null ? languageCode  : "en";
    Config().locale = Locale(languageCode);

    await  SessionHelper().setSelectedLanguage(languageCode);
    if (newSelectedCountry != null) {
      selectedCountry = newSelectedCountry;
      await SessionHelper().setSelectedCountryId(newSelectedCountry.id);
    }
    await EasyLocalization.of(context).setLocale(Config().locale);
    await getContext().setLocale( Config().locale);
    showGenericConfirmDialog(
        getContext(), null, LocaleKeys.successSettingSaved.tr(),
        onConfirm: () {
      Phoenix.rebirth(context);
    }, onCancel: (){
      Phoenix.rebirth(context);
    });
  }

  void getLanguageCode() async {
    SessionHelper().getLanguage().then((value) {
      languageCode = value != null ? value.languageCode : Config().locale;
      refreshUI();
    });
  }
}
