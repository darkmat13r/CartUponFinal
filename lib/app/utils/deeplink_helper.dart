import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class DeeplinkHelper {
  static handle(BuildContext context, String link) {
    if(link == null){
      return;
    }
    Logger().e("DeepLink ${link}");
    Logger().e("link.contains(product) ${link.contains("product/")}");
    Logger().e("link.contains(product/details/) ${link.contains("category")}");
    var parts = split(link);
    var id = "";
    if (parts.length > 0 && parts[parts.length - 1] != "#") {
      id = parts[parts.length - 1];
    }
    if (id.isEmpty) {
      return;
    }
    Uri uri = Uri.parse(link);
    if (link.contains("product/details") || link.contains("product")) {
      if (uri.queryParameters != null && uri.queryParameters.containsKey("id")){
        AppRouter().productDetailsById(context,uri.queryParameters["id"]);
      }else if(id.isNotEmpty){
        AppRouter().productDetailsBySlug(context, id);
      }
    } else if (link.contains("category")) {
      if (uri.queryParameters != null && uri.queryParameters.containsKey("id")){
        AppRouter().categorySearchById(context, uri.queryParameters["id"]);
      }
    } else if (link.contains("query")) {
      if (uri.queryParameters != null && uri.queryParameters.containsKey("query")){
        AppRouter().querySearch(context, uri.queryParameters["query"]);
      }
    } else if (link.contains("order")) {
      if (uri.queryParameters != null && uri.queryParameters.containsKey("id")){
        AppRouter().orderDetailsById(context, uri.queryParameters["id"]);
      }
    }else {
      showGenericSnackbar(context, LocaleKeys.invalidLink.tr(), isError: true);
    }
  }
}
