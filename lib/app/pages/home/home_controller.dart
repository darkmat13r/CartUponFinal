import 'dart:async';

import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/home/home_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/deeplink_helper.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/repositories/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:pushwoosh/pushwoosh.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;
class HomeController extends BaseController{

  HomePresenter _homePresenter;
  StreamSubscription _sub;
  HomeController(authRepo)  : _homePresenter = HomePresenter(authRepo){
    initUniLinks();
  }
  Future<void> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      openLink(initialLink);
    } on PlatformException {
      showGenericSnackbar(getContext(), LocaleKeys.invalidLink.tr(),
          isError: true);
    }
    _sub = linkStream.listen((String link) {
      // Parse the link and warn the user, if it is not correct
      Logger().e(link);
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
      Logger().e(err);
    });
    Pushwoosh pushwoosh = Pushwoosh.getInstance;
    pushwoosh.onDeepLinkOpened.listen((link) {
      var message = "Link opened:\n" + link;
      Logger().e(message);
      DeeplinkHelper.handle(getContext(), link);
    });
  }

  openLink(String link) {
    DeeplinkHelper.handle(getContext(), link);
  }
  @override
  void onResumed() {

    super.onResumed();
  }
  @override
  void initListeners() {
    initBaseListeners(_homePresenter);

  }

  @override
  void onDisposed() {
    _sub.cancel();
    super.onDisposed();
  }


  void goToProductDetails(){
    Navigator.of(getContext()).pushNamed('/product');
  }
}