import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:coupon_app/app/components/circular_progress.dart';
import 'package:coupon_app/app/pages/login/login_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/device/repositories/device_location_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginPage extends View {
  @override
  State<StatefulWidget> createState() => LoginPageView();
}

class LoginPageView extends ViewState<LoginPage, LoginController> {
  LoginPageView() : super(LoginController());

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                _logo,
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                Text(
                  LocaleKeys.welcomeTo.tr(args: [LocaleKeys.appName.tr()]),
                  style: heading4,
                ),
                SizedBox(
                  height: Dimens.spacingNormal,
                ),
                Text(
                  LocaleKeys.signInToContinue.tr(),
                  style: bodyTextNormal2,
                ),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                _loginForm(),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                orDivider,
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                googleLogin,
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                facebookLogin,
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                TextButton(
                  onPressed: () => {},
                  child: Text(
                    LocaleKeys.forgotPassword.tr(),
                    style: buttonText.copyWith(color: AppColors.primary),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.dontHaveAccount.tr(),
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: Text(
                        LocaleKeys.register.tr(),
                        style: buttonText.copyWith(color: AppColors.primary),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );

  Widget get googleLogin => SizedBox(
        width: double.infinity,
        height: Dimens.buttonHeight,
        child: OutlinedButton(
          onPressed: () => {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //Center Column contents vertically,
            crossAxisAlignment: CrossAxisAlignment.center,
            //Center Column contents horizontally,
            children: [
              Icon(
                FontAwesomeIcons.google,
              ),

              Expanded(
                child: Text(
                  LocaleKeys.loginWithGoogle.tr(),
                  textAlign: TextAlign.center,
                  style: buttonText.copyWith(color: AppColors.neutralGray),
                ),
              ),
            ],
          ),
        ),
      );

  Widget get facebookLogin => SizedBox(
        width: double.infinity,
        height: Dimens.buttonHeight,
        child: OutlinedButton(
          onPressed: () => {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //Center Column contents vertically,
            crossAxisAlignment: CrossAxisAlignment.center,
            //Center Column contents horizontally,
            children: [
              Icon(
                FontAwesomeIcons.facebookF,
                color: AppColors.facebook,
              ),

              Expanded(
                child: Text(
                  LocaleKeys.loginWithFb.tr(),
                  textAlign: TextAlign.center,
                  style: buttonText.copyWith(color: AppColors.neutralGray),
                ),
              ),
            ],
          ),
        ),
      );
  final Widget _logo = Center(
    child: Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        Positioned.fill(
          child: Icon(
            Icons.card_giftcard_outlined,
            color: Colors.white,
            size: 40,
          ),
        )
      ],
    ),
  );

  Widget get orDivider => Row(children: <Widget>[
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 10.0, right: 15.0),
              child: Divider(
                color: AppColors.neutralGray,
                height: 4,
              )),
        ),
        Text(
          LocaleKeys.or.tr(),
          style: bodyTextMedium1.copyWith(color: AppColors.neutralGray),
        ),
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 15.0, right: 10.0),
              child: Divider(
                color: AppColors.neutralGray,
                height: 4,
              )),
        ),
      ]);

  Widget _loginForm() {
    return ControlledWidgetBuilder<LoginController>(builder: (BuildContext context, LoginController controller) {
      return Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Feather.mail),
                hintText: LocaleKeys.hintEmail.tr()),
          ),
          SizedBox(
            height: Dimens.spacingMedium,
          ),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Feather.lock),
              hintText: LocaleKeys.hintPassword.tr(),
            ),
          ),
          SizedBox(
            height: Dimens.spacingMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                controller.goToHome();
              },
              child: Text(
                LocaleKeys.signIn.tr(),
                style: buttonText.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    },
    );
  }
}
