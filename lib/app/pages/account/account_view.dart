import 'package:coupon_app/app/components/rounded_box.dart';
import 'package:coupon_app/app/pages/account/account_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AccountPage extends View {
  @override
  State<StatefulWidget> createState() => AccountPageState();
}

class AccountPageState extends ViewState<AccountPage, AccountController> {
  AccountPageState() : super(AccountController(DataAuthenticationRepository()));

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: _body,
      );

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext context, AccountController controller) {
        var menuItems = [
          controller.currentUser != null
              ? _optionItem(
                  Pages.profile,
                  MaterialCommunityIcons.account_circle,
                  LocaleKeys.editProfile.tr(),
                  LocaleKeys.descUpdateProfile.tr())
              : SizedBox(),
          _optionItem(Pages.orders, MaterialCommunityIcons.cart,
              LocaleKeys.order.tr(), LocaleKeys.descOrder.tr()),
          controller.currentUser != null
              ? _optionItem(
                  Pages.changePassword,
                  MaterialCommunityIcons.lock,
                  LocaleKeys.changePassword.tr(),
                  LocaleKeys.descUpdatePassword.tr())
              : SizedBox(),
          _optionItem(Pages.addresses, MaterialCommunityIcons.pin,
              LocaleKeys.address.tr(), LocaleKeys.descAddress.tr()),
          _optionItem(Pages.profile, MaterialCommunityIcons.wallet,
              LocaleKeys.wallet.tr(), LocaleKeys.descWallet.tr()),
          controller.currentUser != null
              ? _optionItemClickable(
                  Pages.addresses,
                  MaterialCommunityIcons.location_exit,
                  LocaleKeys.logout.tr(),
                  null, () {
                  controller.logout();
                })
              : SizedBox(),
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _notLoggedInHeader,
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return menuItems[index];
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: AppColors.neutralGray,
                  );
                },
              ),
            )
          ],
        );
      });

  get _profileHeader => ControlledWidgetBuilder(
          builder: (BuildContext context, AccountController controller) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.spacingMedium),
          child:controller.currentUser.user != null ? RichText(
              text: TextSpan(children: [
            TextSpan(
                text: LocaleKeys.greetings.tr(),
                style: heading4.copyWith(color: AppColors.neutralGray)),
            TextSpan(
                text:
                    "${controller.currentUser.user != null ? controller.currentUser.user.first_name : ""} ${controller.currentUser.user.last_name}",
                style: heading4.copyWith(color: AppColors.primary)),
          ])):  SizedBox(),
        );
      });

  get _notLoggedInHeader => ControlledWidgetBuilder(
          builder: (BuildContext context, AccountController controller) {
        return Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Container(
                    color: AppColors.neutralDark.withAlpha(120),
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: Container(
                    color: AppColors.neutralLight,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacingMedium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.neutralLight,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimens.cornerRadius)),
                          border: Border.all(
                              color: AppColors.neutralGray, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimens.spacingMedium),
                        child: Icon(
                          Feather.user,
                          size: 60,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimens.spacingMedium,
                    ),
                    Expanded(
                        child: controller.currentUser == null
                            ? RaisedButton(
                                onPressed: () {
                                  controller.login();
                                },
                                child: Text(
                                  LocaleKeys.loginSignup.tr(),
                                  style: buttonText,
                                ),
                              )
                            : _profileHeader)
                  ],
                ),
              ),
            )
          ],
        );
      });

  Widget _optionItemClickable(
      page, icon, name, description, Function onPressed) {
    return ControlledWidgetBuilder(
        builder: (BuildContext context, AccountController controller) {
      return InkWell(
        onTap: () {
          onPressed();
        },
        child: ListTile(
          leading: Icon(
            icon,
            color: AppColors.neutralGray,
            size: 24,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: heading5.copyWith(color: AppColors.neutralDark)),
              description != null
                  ? Text(description,
                      style:
                          captionNormal1.copyWith(color: AppColors.neutralGray))
                  : SizedBox(),
            ],
          ),
        ),
      );
    });
  }

  Widget _optionItem(page, icon, name, description) {
    return ControlledWidgetBuilder(
        builder: (BuildContext context, AccountController controller) {
      return InkWell(
        onTap: () {
          controller.goToPage(page);
        },
        child: ListTile(
          leading: Icon(
            icon,
            color: AppColors.neutralGray,
            size: 24,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: heading5.copyWith(color: AppColors.neutralDark)),
              description != null
                  ? Text(description,
                      style:
                          captionNormal1.copyWith(color: AppColors.neutralGray))
                  : SizedBox(),
            ],
          ),
        ),
      );
    });
  }
}
