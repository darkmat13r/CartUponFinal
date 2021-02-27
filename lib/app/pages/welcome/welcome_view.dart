import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:coupon_app/app/pages/welcome/welcome_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';

class WelcomePage extends View {
  @override
  State<StatefulWidget> createState() => WelcomePageView();
}

class WelcomePageView extends ViewState<WelcomePage, WelcomeController> {
  WelcomePageView() : super(WelcomeController());

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: body,
      );
  final Widget _logo = SizedBox(
      height: 90,
      child: Image.asset(
        Resources.logo,
      ));

  get body => ControlledWidgetBuilder(builder: (BuildContext context, WelcomeController controller){
    return ListView(
      children: [
        SizedBox(
          height: 24,
          width: double.infinity,
        ),
        _logo,
        SizedBox(
          height: 24,
          width: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.spacingMedium),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(Dimens.spacingMedium),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              ),

              Text(
                "Sign/Register to continue",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.neutralGray),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    controller.register();
                  },
                  child: Text(
                    LocaleKeys.register.tr(),
                    style: buttonText,
                  ),
                ),
              ),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.buttonCornerRadius),
                      side: BorderSide(color: AppColors.accent)),
                  onPressed: () {
                    controller.login();
                  },
                  child: Text(
                    LocaleKeys.signIn.tr(),
                    style: buttonText.copyWith(color: AppColors.accent),
                  ),
                ),
              ),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    LocaleKeys.loginAsGuest.tr(),
                    style: buttonText.copyWith(color: AppColors.accent),
                  ))
            ],
          ),
        ),
        SizedBox(
          height: 24,
          width: double.infinity,
        ),
        Text(
          "By continuing, you agree to accept our \nPrivacy Policy & Terms of Service.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10, color: Colors.black),
        ),
        SizedBox(
          height: 24,
          width: double.infinity,
        ),
        SizedBox(
          height: 24,
          width: double.infinity,
        ),
      ],
    );
  });

  Widget get googleLogin => Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 16),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: MaterialButton(
            color: Colors.white,
            onPressed: () => {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //Center Column contents vertically,
              crossAxisAlignment: CrossAxisAlignment.center,
              //Center Column contents horizontally,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(
                      image: AssetImage(
                        Resources.google_logo,
                      ),
                      height: 36.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "SIGN UP WITH GOOGLE",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      );

  Widget get facebookLogin => Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 16),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: MaterialButton(
            color: Colors.blue.shade800,
            onPressed: () => {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //Center Column contents vertically,
              crossAxisAlignment: CrossAxisAlignment.center,
              //Center Column contents horizontally,
              children: [
                Icon(
                  MaterialCommunityIcons.facebook,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "SIGN UP WITH FACEBOOK",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );

  Container get banner => Container(
          child: Image.asset(
        Resources.login_banner,
      ));

  Widget get orDivider => Row(children: <Widget>[
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 10.0, right: 15.0),
              child: Divider(
                color: Colors.black,
                height: 4,
              )),
        ),
        Text(
          "or",
          style: TextStyle(color: Colors.black),
        ),
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 15.0, right: 10.0),
              child: Divider(
                color: Colors.black,
                height: 4,
              )),
        ),
      ]);

  Widget get buttonJoinUs => SizedBox(
        width: double.infinity,
        height: 82,
        child: RaisedButton(
          onPressed: () {},
          color: AppColors.accent,
          child: Center(
              child: Text(
            "Login Now",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white),
          )),
        ),
      );
}
