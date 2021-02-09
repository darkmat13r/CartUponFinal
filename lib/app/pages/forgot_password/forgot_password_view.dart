import 'package:coupon_app/app/components/loading_button.dart';
import 'package:coupon_app/app/pages/forgot_password/forgot_password_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ForgotPasswordPage extends View{
  @override
  State<StatefulWidget> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends ViewState<ForgotPasswordPage, ForgotPasswordController>{
  ForgotPasswordPageState() : super(ForgotPasswordController());

  final _formKey = GlobalKey<FormState>();
  @override
  Widget get view => Scaffold(
    key: globalKey,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Feather.chevron_left, color: AppColors.neutralGray),
      ),
      title: Text(
        LocaleKeys.forgotPassword.tr(),
        style: heading4.copyWith(color: AppColors.neutralDark),
      ),
      shape: appBarShape,
    ),
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
              LocaleKeys.forgotPasswordTitle.tr(args: [LocaleKeys.appName.tr()]),
              style: heading4,
            ),
            SizedBox(
              height: Dimens.spacingNormal,
            ),
            Text(
              LocaleKeys.forgotPasswordSubtitle.tr(),
              style: bodyTextNormal2,
            ),
            SizedBox(
              height: Dimens.spacingLarge,
            ),
            SizedBox(
              height: Dimens.spacingLarge,
            ),
            _forgotPasswordForm(),
            SizedBox(
              height: Dimens.spacingLarge,
            ),

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

  _forgotPasswordForm() {
    return Form(child: Column(
      children: [
        _emailAddress,
        SizedBox(
          height: Dimens.spacingLarge,
        ),
        LoadingButton(onPressed: (){},text: LocaleKeys.sendInstructions,)
      ],
    ));
  }

  get _emailAddress => ControlledWidgetBuilder(builder: (BuildContext context, ForgotPasswordController controller){
    return  TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return LocaleKeys.errorUsernameRequired.tr();
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Feather.mail),
          hintText: LocaleKeys.hintEmail.tr()),
    );
  });

}