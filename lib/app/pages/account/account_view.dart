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
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Text(
        LocaleKeys.account.tr(),
        style: heading4.copyWith(color: AppColors.neutralDark),
      ),
      shape: appBarShape,
    ),
    key: globalKey,
    body: _body,
  );

  get _body => ListView(
    children: [
      _optionItem(Pages.profile, Feather.user, LocaleKeys.profile.tr()),
      _optionItem(Pages.orders, Feather.shopping_bag, LocaleKeys.order.tr()),
      _optionItem(Pages.profile, Feather.map_pin, LocaleKeys.address.tr()),
      _optionItem(Pages.profile, Feather.credit_card, LocaleKeys.payment.tr()),
    ],
  );
  Widget _optionItem(page,icon,name) {
   return ControlledWidgetBuilder(builder: (BuildContext context, AccountController controller) {
      return GestureDetector(
        onTap: (){
          controller.goToPage(page);
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primary,),
                SizedBox(
                  width: Dimens.spacingMedium,
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