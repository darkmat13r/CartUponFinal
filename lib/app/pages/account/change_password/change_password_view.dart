import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/loading_button.dart';
import 'package:coupon_app/app/pages/account/change_password/change_password_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ChangePasswordPage extends View {
  @override
  State<StatefulWidget> createState() => ChangePasswordPageState();
}

class ChangePasswordPageState
    extends ViewState<ChangePasswordPage, ChangePasswordController> {
  ChangePasswordPageState()
      : super(ChangePasswordController(DataAuthenticationRepository()));
  final _formKey = GlobalKey<FormState>();


  @override
  Widget get view => Scaffold(
        appBar: customAppBar(
            title: Text(
          LocaleKeys.changePassword.tr(),
          style: heading5.copyWith(color: AppColors.primary),
        )),
        key: globalKey,
        body: _body,
      );

  get _body => Padding(
        padding: const EdgeInsets.all(Dimens.spacingMedium),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              _newPassword,
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              _confirmNewPassword,
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              _save
            ],
          ),
        ),
      );

  get _oldPassword => ControlledWidgetBuilder(
          builder: (BuildContext context, ChangePasswordController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.oldPassword.tr(),
              style: labelText,
            ),
            SizedBox(
              height: Dimens.spacingNormal,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Feather.lock), hintText: "*************"),
            )
          ],
        );
      });

  get _newPassword => ControlledWidgetBuilder(
          builder: (BuildContext context, ChangePasswordController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.newPassword.tr(),
              style: labelText,
            ),
            SizedBox(
              height: Dimens.spacingNormal,
            ),
            TextFormField(
              obscureText: controller.isPasswordHidden,
              controller: controller.newPasswordController,
              focusNode: controller.newPasswordFocus,
              validator: (value) {
                if (value.isEmpty) {
                  return LocaleKeys.errorPasswordRequired.tr();
                }
                return null;
              },
              decoration: InputDecoration(
                  suffix: InkWell(
                      onTap: () {
                        controller.togglePassword();
                      },
                      child: Icon(
                          controller.isPasswordHidden ? Feather.eye : Feather.eye_off)),
                  prefixIcon: Icon(Feather.lock), hintText: "*************"),
            )
          ],
        );
      });

  get _confirmNewPassword => ControlledWidgetBuilder(
          builder: (BuildContext context, ChangePasswordController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.confirmNewPassword.tr(),
              style: labelText,
            ),
            SizedBox(
              height: Dimens.spacingNormal,
            ),
            TextFormField(
              controller: controller.confirmPasswordController,
              obscureText: controller.isConfirmPasswordHidden,
              focusNode: controller.confirmPasswordFocus,
              validator: (value) {
                if (value.isEmpty) {
                  return LocaleKeys.errorPasswordRequired.tr();
                }
                if (value != controller.newPasswordController.text) {
                  return LocaleKeys.passwordDontMatch.tr();
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Feather.lock),
                hintText: "*************",
                suffix: InkWell(
                    onTap: () {
                      controller.toggleConfirmPassword();
                    },
                    child: Icon(
                        controller.isConfirmPasswordHidden ? Feather.eye : Feather.eye_off)),
              ),
            )
          ],
        );
      });

  get _save => ControlledWidgetBuilder(
          builder: (BuildContext context, ChangePasswordController controller) {
        return LoadingButton(
            onPressed: () {
              controller.checkForm({
                'context': context,
                'formKey': _formKey,
                'globalKey': globalKey
              });
            },
            isLoading: controller.isLoading,
            text: LocaleKeys.changePassword.tr());
      });
}
