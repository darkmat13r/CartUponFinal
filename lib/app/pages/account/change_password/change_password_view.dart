import 'package:coupon_app/app/components/loading_button.dart';
import 'package:coupon_app/app/pages/account/change_password/change_password_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
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
  ChangePasswordPageState() : super(ChangePasswordController());

  @override
  Widget get view => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Feather.chevron_left, color: AppColors.neutralGray),
          ),
          title: Text(
            LocaleKeys.changePassword.tr(),
            style: heading4.copyWith(color: AppColors.neutralDark),
          ),
          shape: appBarShape,
        ),
        key: globalKey,
        body: _body,
      );

  get _body => Padding(
    padding: const EdgeInsets.all(Dimens.spacingMedium),
    child: ListView(
          shrinkWrap: true,
          children: [
            _oldPassword,
            SizedBox(
              height: Dimens.spacingMedium,
            ),
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
              decoration: InputDecoration(
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
              decoration: InputDecoration(
                  prefixIcon: Icon(Feather.lock), hintText: "*************"),
            )
          ],
        );
      });

  get _save => ControlledWidgetBuilder(
      builder: (BuildContext context, ChangePasswordController controller) {
        return LoadingButton(onPressed: (){
          controller.save();
        }, text: LocaleKeys.changePassword.tr());
      });
}
