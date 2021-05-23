import 'package:coupon_app/app/pages/splash/splash_controller.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';
import 'package:devicelocale/devicelocale.dart';

class SettingsController extends SplashController {
  SettingsController(CountryRepository repo) : super(repo) {
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
  }

  void setLanguage(languageCode) {
    this.languageCode = languageCode;
    refreshUI();
  }

  void save() {
    Config().locale = Locale(languageCode);
    SessionHelper().setSelectedLanguage(languageCode);
    getContext().setLocale(Locale(languageCode));
    if (newSelectedCountry != null) {
      selectedCountry = newSelectedCountry;
      SessionHelper().setSelectedCountryId(newSelectedCountry.id);
    }

    showGenericConfirmDialog(
        getContext(), null, LocaleKeys.successSettingSaved.tr(), onConfirm: () {
      Navigator.of(getContext()).pop();
    });
  }

  void getLanguageCode() async {
    SessionHelper().getLanguage().then((value) {
      languageCode = value.languageCode;
      refreshUI();
    });
  }
}
