import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/main/main_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class MainController extends BaseController {
  bool isLoggedIn = false;
  int selectedIndex = 0;

  MainPresenter _presenter;
  GlobalKey<ScaffoldState> _drawerKey;

  MainController(authRepo) : _presenter = MainPresenter(authRepo) {

  }

  @override
  void initListeners() {
    initBaseListeners(_presenter);
  }

  void checkProfile() {
    isLoggedIn = currentUser != null;
    if (currentUser == null) {
      login();
    }
  }



  onResumed() {
    super.onResumed();
    Logger().e("OnResume ${_currentContext} ${currentUser} ${_drawerKey}");
  }

  BuildContext _currentContext;

  onAuthComplete() {
    Logger()
        .d("onAuthComplete ${_currentContext} ${currentUser} ${_drawerKey}");
    super.onAuthComplete();
  }

  setKey(drawerKey) {
    if (_drawerKey == null) {
      _drawerKey = drawerKey;
      Future.delayed(const Duration(milliseconds: 500), () {
        Logger().e("Code Should Run");
        showLoginDialog();
      });
    }
  }

  startSearch(GlobalKey key, String query) {
    AppRouter().querySearch(key.currentContext, query);
  }

  Future<void> login() async {
    await Navigator.of(getContext()).pushNamed(Pages.welcome);
    _presenter.getUser();
  }

  Future<void> showLoginDialog() async {
    int days = await SessionHelper().lastShownPopup();
    bool isPopupShown = await SessionHelper().isPopupShown();
    Logger().e("LastPopup Shown in ${days}");
    Logger().e("LastPopup Shown isPopupShown ${isPopupShown}");
    if (isPopupShown && days < 7) {
      return;
    }
    if (currentUser == null && _currentContext == null && _drawerKey != null) {
      SessionHelper().updateLastShownPopup();
      SessionHelper().setShownPopup();
      showDialog(
          context: _drawerKey.currentContext,
          builder: (ctx) {
            _currentContext = ctx;
            return AlertDialog(
              title: new Text(
                LocaleKeys.completePurchaseFaster.tr(),
                style: bodyTextMedium1,
              ),
              titlePadding: EdgeInsets.only(
                  left: Dimens.spacingMedium,
                  right: Dimens.spacingMedium,
                  top: Dimens.spacingMedium),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
              actionsPadding: EdgeInsets.zero,
              content: new Text(LocaleKeys.messageSignIn.tr(),
                  style: bodyTextNormal2),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text(
                    LocaleKeys.later.tr(),
                    style: buttonText.copyWith(color: AppColors.accent),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.of(_drawerKey.currentContext)
                        .pushNamed(Pages.login);
                  },
                  child: Text(
                    LocaleKeys.signIn.tr(),
                    style: buttonText.copyWith(color: AppColors.accent),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.of(_drawerKey.currentContext)
                        .pushNamed(Pages.register);
                  },
                  child: Text(
                    LocaleKeys.signUp.tr(),
                    style: buttonText.copyWith(color: AppColors.accent),
                  ),
                )
              ],
            );
          });
    }
  }
}
