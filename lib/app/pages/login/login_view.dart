import 'package:coupon_app/app/components/loading_button.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:coupon_app/app/components/circular_progress.dart';
import 'package:coupon_app/app/pages/login/login_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginPage extends View {
  final bool returnResult;

  LoginPage({this.returnResult});

  @override
  State<StatefulWidget> createState() => LoginPageView( returnResult: returnResult);
}

class LoginPageView extends ViewState<LoginPage, LoginController> {
  LoginPageView( {bool returnResult}) : super(LoginController(DataAuthenticationRepository( ),returnResult: returnResult));
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;

  @override
  Widget get view => AutofillGroup(child: Scaffold(
    key: globalKey,
    appBar: AppBar(elevation: 0,),
    body: _body,
  ));

  Widget get _body => SingleChildScrollView(
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

          _forgotPassword,
          _registerButton
        ],
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
                MaterialCommunityIcons.google,
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
                MaterialCommunityIcons.facebook,
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
  final Widget _logo = SizedBox(
      height: 90,
      child: Image.asset(
        Resources.logo,
      ));

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

  get _registerButton => ControlledWidgetBuilder(
          builder: (BuildContext context, LoginController controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.dontHaveAccount.tr(),
            ),
            TextButton(
              onPressed: () => {controller.register()},
              child: Text(
                LocaleKeys.register.tr(),
                style: buttonText.copyWith(color: AppColors.primary),
              ),
            )
          ],
        );
      });

  get _forgotPassword => ControlledWidgetBuilder(
          builder: (BuildContext context, LoginController controller) {
        return TextButton(
          onPressed: () => {controller.forgotPassword()},
          child: Text(
            LocaleKeys.forgotPassword.tr(),
            style: buttonText.copyWith(color: AppColors.primary),
          ),
        );
      });

  Widget _loginForm() {
    return ControlledWidgetBuilder<LoginController>(
      builder: (BuildContext context, LoginController controller) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.emailTextController,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.username],
                validator: (value) {
                  if (value.isEmpty) {
                    return LocaleKeys.errorUsernameRequired.tr();
                  }
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Feather.mail),
                    hintText: LocaleKeys.hintEmailMobile.tr()),
              ),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: controller.passwordTextController,
                obscureText: _isPasswordHidden,
                autofillHints: const [AutofillHints.password],
                validator: (value) {
                  if (value.isEmpty) {
                    return LocaleKeys.errorPasswordRequired.tr();
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Feather.lock),
                  suffix: InkWell(
                      onTap: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                      child: Icon(
                          _isPasswordHidden ? Feather.eye : Feather.eye_off)),
                  hintText: LocaleKeys.hintPassword.tr(),
                ),
              ),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              SizedBox(
                width: double.infinity,
                child: LoadingButton(
                  onPressed: () {
                    controller.checkForm({
                      'context': context,
                      'formKey': _formKey,
                      'globalKey': globalKey
                    });
                  },
                  isLoading: controller.isLoading,
                  text: LocaleKeys.signIn.tr(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
