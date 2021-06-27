
import 'dart:io';

import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/splash/splash_presenter.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class SplashController extends Controller {
  final SplashPresenter _presenter;

  List<Country> countries;
  Country selectedCountry;

  SplashController(CountryRepository repo) : _presenter = SplashPresenter(repo);

  @override
  void initListeners() {
    _presenter.getCountriesOnNext = (response) {
      countries = response;
      refreshUI();
      onLoadCountries();
    };
    _presenter.getCountriesOnError = (e) {
      home();
    };
    _presenter.getCountriesOnComplete = () {
      home();
    };
  }

  home() {
    Navigator.of(getContext()).pushReplacementNamed(Pages.main);
  }

  void onLoadCountries() async{
    var selectCountryId = await SessionHelper().getSelectedCountryId();
    //Logger().e(selectCountryId);
    if(selectCountryId == null || selectCountryId == 0){
      if(countries != null && countries.length > 0){
        var firstFind;
        var locale = await Devicelocale.currentLocale;
        String s = locale;
        //Logger().e("Locale ${locale}");
        int idx = s.indexOf(Platform.isIOS ?  "-" :"_");
        if(idx >= 0){
          List parts = [s.substring(0,idx).trim(), s.substring(idx+1).trim()];
          if(parts.length >1){
            locale = parts[1];
          }else if(parts.length > 0){
            locale = parts[0];
          }
        }
        //Logger().e(locale);
        try{
          firstFind = countries.firstWhere((element) => element.country_code.toLowerCase() == locale.toLowerCase());
        }catch(e){
          //Logger().e(e);
        }
        if(firstFind == null){
          firstFind = countries.first;
        }
        //Logger().e(firstFind);
        selectCountryId = firstFind.id;
        SessionHelper().setSelectedCountryId(firstFind.id);
      }
    }
    if(countries != null && countries.length > 0){
      try{
        selectedCountry = countries.firstWhere((element) => element.id == selectCountryId);
      }catch(e){

      }
    }
    Config().selectedCountry = selectedCountry;

  }
}
