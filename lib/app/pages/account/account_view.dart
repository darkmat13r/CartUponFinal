import 'package:coupon_app/app/pages/account/account_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_icons/flutter_icons.dart';
class AccountPage extends View{
  @override
  State<StatefulWidget> createState() => AccountPageState();

}


class AccountPageState extends ViewState<AccountPage, AccountController>{
  AccountPageState() : super(AccountController());

  @override
  Widget get view => Scaffold(
    key: globalKey,
    body: _body,
  );

  get _body => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(Dimens.spacingMedium),
        child: RichText(text: TextSpan(
            children: [
              TextSpan( text: "Hello, ", style: heading4.copyWith(color: AppColors.neutralGray)),
              TextSpan( text: "Avinash", style: heading4.copyWith(color: AppColors.primary)),
            ]
        )),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingLarge),
          child: GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5),
            children: [
              _optionItem(Pages.profile, MaterialCommunityIcons.account_circle, LocaleKeys.editProfile.tr()),
              _optionItem(Pages.orders, MaterialCommunityIcons.cart, LocaleKeys.order.tr()),
              _optionItem(Pages.changePassword, MaterialCommunityIcons.lock, LocaleKeys.changePassword.tr()),
              _optionItem(Pages.addresses, MaterialCommunityIcons.pin, LocaleKeys.address.tr()),
              _optionItem(Pages.profile, MaterialCommunityIcons.wallet, LocaleKeys.wallet.tr()),
              _optionItem(Pages.addresses, MaterialCommunityIcons.location_exit, "Logout"),
            ],
          ),
        ),
      )
    ],
  );
  Widget _optionItem(page,icon,name) {
   return ControlledWidgetBuilder(builder: (BuildContext context, AccountController controller) {
      return InkWell(
        onTap: (){
          controller.goToPage(page);
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: Column(
              children: [
                Flexible(
                  flex: 2,
                    child: Icon(icon, color: AppColors.primary, size: 48,)),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                Text(name, style: heading5.copyWith(color: AppColors.neutralDark),)

              ],
            ),
          ),
        ),
      );
    });
  }
}