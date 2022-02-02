
import 'dart:io';

import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/splash/splash_presenter.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/ipdetect/IPDetectResponse.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/repositories/home_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class SplashController extends Controller {
  final SplashPresenter _presenter;

  List<Country> countries;
  Country selectedCountry;
  IPDetectResponse ipDetectResponse;

  SplashController(CountryRepository repo, HomeRepository _homeRepo) : _presenter = SplashPresenter(repo, _homeRepo);

  @override
  void initListeners() {
    _presenter.detectCountryOnComplete = (){
      _presenter.fetchCountries();
    };
    _presenter.detectCountryOnNext = (IPDetectResponse response){
      this.ipDetectResponse = response;

    };
    _presenter.detectCountryOnError = (e){
      home();
    };
    _presenter.getCountriesOnNext = (response) {
      countries = response;
      refreshUI();
      onLoadCountries();
      home();
    };
    _presenter.getCountriesOnError = (e) {
      home();
      Logger().e("GetCOuntries error ${e}");
    };
    _presenter.getCountriesOnComplete = () {
     // home();
    };

    _presenter.getWebSettingsOnNext = (response){
        Config().webSettings = response;
    };
    _presenter.getWebSettingsOnComplete =(){

    };
    _presenter.getWebSettingsOnError = (e){

    };
  }

  home() {
    Navigator.of(getContext()).pushReplacementNamed(Pages.main);
  }

  void onLoadCountries() async{
    var selectCountryId = await SessionHelper().getSelectedCountryId();
    Logger().e(selectCountryId);
    if(countries != null && countries.length > 0){
      try{
        selectedCountry = countries.firstWhere((element) => element.id == selectCountryId);
      }catch(e){
        Logger().e("Selected country selectCountryId ${countries.map((e) => e.id)}");
      }
    }
    if(selectedCountry == null || selectCountryId == null || selectCountryId == 0){
      Logger().e("Countries  ${countries}");

      if(countries != null && countries.length > 0){
        var firstFind;
        var locale = await Devicelocale.currentLocale;
        String s = locale;
        Logger().e("Locale ${locale}");
        int idx = s.indexOf(Platform.isIOS ?  "-" :"_");
        if(idx >= 0){
          List parts = [s.substring(0,idx).trim(), s.substring(idx+1).trim()];
          if(parts.length >1){
            locale = parts[1];
          }else if(parts.length > 0){
            locale = parts[0];
          }
        }

        if(ipDetectResponse != null){
          try{

            firstFind = countries.firstWhere((element) => element.country_code.toLowerCase() == ipDetectResponse.countryCode.toLowerCase());
          }catch(e){
            Logger().e(e);
          }
        }
        if(firstFind == null){
          try{
            firstFind = countries.firstWhere((element) => element.country_code.toLowerCase() == locale.toLowerCase());
          }catch(e){
            Logger().e(e);
          }
        }
        if(firstFind == null){
          firstFind = countries.first;
        }

        selectCountryId = firstFind.id;
        SessionHelper().setSelectedCountryId(firstFind.id);
      }
    }
    if(countries != null && countries.length > 0){
      try{
        selectedCountry = countries.firstWhere((element) => element.id == selectCountryId);
      }catch(e){
        Logger().e("Selected country selectCountryId ${countries.map((e) => e.id)}");
      }
    }
    Logger().e("Selected country selectCountryId ${selectCountryId}");
    Logger().e("Selected country ${selectedCountry}");
    Config().selectedCountry = selectedCountry;

  }
}
