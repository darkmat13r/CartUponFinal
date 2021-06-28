import 'package:coupon_app/app/components/rounded_box.dart';
import 'package:coupon_app/app/pages/account/account_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/wallet/add/add_to_wallet_view.dart';
import 'package:coupon_app/app/pages/welcome/welcome_view.dart';
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
  Function onLogout;

  AccountPage({this.onLogout});

  @override
  State<StatefulWidget> createState() => AccountPageState(onLogout);
}

class AccountPageState extends ViewState<AccountPage, AccountController> {
  AccountPageState(onLogout) : super(AccountController(onLogout, DataAuthenticationRepository()));

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: _body,
      );

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext context, AccountController controller) {
        var menuItems = [
          _optionItem(
                  Pages.profile,
                  MaterialCommunityIcons.account_circle,
                  LocaleKeys.myProfile.tr(),
                  LocaleKeys.descUpdateProfile.tr())
             ,
          _optionItem(Pages.orders, MaterialCommunityIcons.cart,
              LocaleKeys.order.tr(), LocaleKeys.descOrder.tr()),
          _optionItem(
                  Pages.changePassword,
                  MaterialCommunityIcons.lock,
                  LocaleKeys.changePassword.tr(),
                  LocaleKeys.descUpdatePassword.tr()),
          _optionItem(Pages.addresses, MaterialCommunityIcons.pin,
              LocaleKeys.addresses.tr(), LocaleKeys.descAddress.tr()),
          _optionItem(Pages.wallet, MaterialCommunityIcons.wallet,
              LocaleKeys.myWallet.tr(), LocaleKeys.descWallet.tr()),
         _optionItemClickable(
                  Pages.main,
                  MaterialCommunityIcons.location_exit,
                  LocaleKeys.logout.tr(),
                  null, () {
                  controller.logout();
                }),
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            controller.currentUser != null ? _profileHeader : SizedBox(),
            Expanded(
              child: controller.currentUser != null ? ListView.separated(
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
              ) : controller.isAuthUserLoading ? SizedBox() :  WelcomePage(),
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

  showAddMoneyToWallet(){
    showBottomSheet(context: context,
        elevation: 12,
        builder: (BuildContext context){
      return Wrap(
        children: [ AddToWalletPage()],
      );
    });
  }
  Widget _optionWalletItem( icon, name, description) {
    return ControlledWidgetBuilder(
        builder: (BuildContext context, AccountController controller) {
          return InkWell(
            onTap: () {
              showAddMoneyToWallet();
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
            ],
          ),
        ),
      );
    });
  }
}
