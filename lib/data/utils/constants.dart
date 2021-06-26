import 'dart:io';

import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';

import './sensitive.dart';
class Constants {
  // APIs
  static const String schema = "https";
  static const String baseUrl = '$schema://$baseUrlNoPrefix/v1';
  static const String baseUrlWithoutV1 = '$schema://$baseUrlNoPrefix';
  static const String usersRoute = '$baseUrl/users';

  static const String loginRoute = '$baseUrl/login/';
  static const String forgotPasswordRoute = '$baseUrl/password/reset/';
  static const String registerRoute = '$baseUrl/customerwebapi/';
  static const String userProfileRoute = '$baseUrl/userCustomerapi/';
  static const String areaRoute = '$baseUrl/areawebapi/';
  static const String blockRoute = '$baseUrl/blockwebapi/';
  static const String addressRoute = '$baseUrl/addresswebapi/';
  static const String addressGetRoute = '$baseUrl/addressGetwebapi/';
  static const String cartRoute = '$baseUrl/cartwebapi/';
  static const String cartGetRoute = '$baseUrl/CartGetAPI/';
  static const String whishlistRoute = '$baseUrl/wishlistapi/';
  static const String userRoute = '$baseUrl/user';
  static const String productDetailRoute = '$baseUrl/productdetail/';

  // APIs no prefix
  //static const String baseUrlNoPrefix = 'cart-upon-api.herokuapp.com';
  static const String baseUrlNoPrefix = 'api.mallzaad.com';
  static const String forgotPasswordPath = '/forgot-password';

  // Local Storage
  static const String tokenKey = 'authentication_token';
  static const String tempIdKey = 'user_temp_id_key';
  static const String userKey = 'user_key';
  static const String isAuthenticatedKey = 'isUserAuthenticated';

  static var sliders = '$baseUrl/sliderreadapi';
  static var categories = '$baseUrl/categoryweb';
  static var products = '$baseUrl/productweb/';
  static var search = '$baseUrl/search/';

  static var home = '$baseUrl/homecommon';

  static var changePassword = "$baseUrl/password/change/";

  static var nationalityRoute = "$baseUrl/nationalitylist";

  static String lastLoginPopupShownKey = "lastLoginPopupShown";

  static String cachedCountiesKey = "countriesCached";
  static String selectCountryId = "selectedCountryId";
  static String selectedLanguage = "selectedLanguage";

  static String countriesRoute = "$baseUrl/countryopenapi/";

  static String isLoginPopupShownKey = "isPopupShown";

  static var orderCreateRoute = "$baseUrl/ordercreate";
  static var orderRoute = "$baseUrl/order";
  static var orderCancelRoute = "$baseUrl/item-cancel-request";
  static var changeCartUserIdRoute = "$baseUrl/cartwebapi/changeUser/";

  static var sendOtp ="$baseUrl/sendOtp";
  static var validateOtp ="$baseUrl/validateOTP";


  static String createUriWithParams(String route, Map<String, String> queryParams){
    return route  + "?" + Uri( queryParameters: queryParams ).query;
  }

}

class Strings {
  static  String registrationFormIncomplete = LocaleKeys.formMustBeFilled.tr();

  static String loginFormIncomplete =  LocaleKeys.formMustBeFilled.tr();
}

extension AuthHeader on String{
  createAuthHeader() async{
    return {
      HttpHeaders.authorizationHeader : "Token ${await SessionHelper().getToken()}"
    };
  }
}