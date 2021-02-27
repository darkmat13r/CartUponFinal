import 'package:coupon_app/app/pages/register/register_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

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

  final Widget _logo = SizedBox(
      height: 90,
      child: Image.asset(
        Resources.logo,
      ));

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

  String selectedGender = "male";
  Widget _registerForm() {
    return ControlledWidgetBuilder<RegisterController>(
      builder: (BuildContext context, RegisterController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(MaterialCommunityIcons.account),
                  hintText: LocaleKeys.fullName.tr()),
            ),
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            Text(LocaleKeys.gender, style: labelText,),
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            Row(
              children: [
                Radio(value: "male", groupValue: selectedGender, onChanged: (value){
                  setState(() {
                    selectedGender = value;
                  });
                }),
                 Text(
                  'Male',
                  style: new TextStyle(fontSize: 16.0),
                ),
                Radio(value: "female", groupValue: selectedGender, onChanged: (value){
                  setState(() {
                    selectedGender = value;
                  });
                }),
                Text(
                  'Female',
                  style: new TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(MaterialCommunityIcons.email),
                  hintText: LocaleKeys.hintEmail.tr()),
            ),
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(MaterialCommunityIcons.calendar),
                  hintText: LocaleKeys.dob.tr()),
            ),
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(MaterialCommunityIcons.phone),
                  hintText: LocaleKeys.phoneNumber.tr()),
            ),
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(MaterialCommunityIcons.lock),
                hintText: LocaleKeys.hintPassword.tr(),
              ),
            ),
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(MaterialCommunityIcons.lock),
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
