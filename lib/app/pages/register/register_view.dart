import 'package:coupon_app/app/pages/register/register_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends View {
  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends ViewState<RegisterPage, RegisterController> {
  RegisterPageState() : super(RegisterController());

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
                  LocaleKeys.letsGetStarted.tr(args: [LocaleKeys.appName.tr()]),
                  style: heading4,
                ),
                SizedBox(
                  height: Dimens.spacingNormal,
                ),
                Text(
                  LocaleKeys.createAnAccount.tr(),
                  style: bodyTextNormal2,
                ),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                _registerForm(),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                _loginButton
              ],
            ),
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

  get _loginButton => ControlledWidgetBuilder(builder:  (BuildContext context, RegisterController controller){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.haveAnAccount.tr(),
        ),
        TextButton(
          onPressed: () => {
            controller.login()
          },
          child: Text(
            LocaleKeys.signIn.tr(),
            style: buttonText.copyWith(color: AppColors.primary),
          ),
        )
      ],
    );
  });

  Widget _registerForm() {
    return ControlledWidgetBuilder<RegisterController>(
      builder: (BuildContext context, RegisterController controller) {
        return Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Feather.user),
                  hintText: LocaleKeys.fullName.tr()),
            ),
            SizedBox(
              height: Dimens.spacingMedium,
            ),
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
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Feather.lock),
                hintText: LocaleKeys.confirmPassword.tr(),
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
                  LocaleKeys.signUp.tr(),
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
