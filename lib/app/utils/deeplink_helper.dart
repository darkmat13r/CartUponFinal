import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class DeeplinkHelper {

  static handle(BuildContext context, String link) {
    if (link == null || link == "#") {
      return;
    }
    var parts = split(link);
    var id = "0";
    if (parts.length > 0 && parts[parts.length - 1] != "#") {
      id = parts[parts.length - 1];
    }
    if(id == "0"){
      return;
    }
    if (link.contains("product/details/")) {
      AppRouter().productDetailsById(
          context, id);
    }else if(link.contains("/category/")){
      AppRouter().categorySearchById(
          context, id);
    }
    else {
      showGenericSnackbar(context, LocaleKeys.invalidLink.tr(),
          isError: true);
    }
  }
}