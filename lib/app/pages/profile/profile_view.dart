import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/pages/profile/profile_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_icons/flutter_icons.dart';
class ProfilePage extends View{
  @override
  State<StatefulWidget> createState() => ProfilePageState();

}


class ProfilePageState extends ViewState<ProfilePage, ProfileController>{
  ProfilePageState() : super(ProfileController());

  @override
  Widget get view => Scaffold(
    appBar: customAppBar(
        title: Text(
          LocaleKeys.profile.tr(),
          style: heading5.copyWith(color: AppColors.primary),
        )),
    key: globalKey,
    body: _body,
  );

  get _body => ControlledWidgetBuilder(builder: (BuildContext context, ProfileController controller){
    return ListView(
      children: [
        _optionItem( Feather.mail, LocaleKeys.email.tr(), "avinashkumawat2@gmail.com", (){}),
        _optionItem( Feather.phone, LocaleKeys.phone.tr(), "+91 94685 6232", (){}),
        _optionItem( Feather.lock, LocaleKeys.changePassword.tr(), "**************", (){
            controller.changePassword();
        }),
      ],
    );
  });
  Widget _optionItem(icon,name, value, Function  onClick) {
    return ControlledWidgetBuilder(builder: (BuildContext context, ProfileController controller) {
      return InkWell(
        onTap: onClick,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primary,),
                SizedBox(
                  width: Dimens.spacingMedium,
                ),
                Expanded(child: Text(name, style: heading5.copyWith(color: AppColors.neutralDark),)),
                Text(value, style: bodyTextNormal2.copyWith(color: AppColors.neutralGray),),
                Icon(Feather.chevron_right, color: AppColors.neutralGray,)
              ],
            ),
          ),
        ),
      );
    });
  }
}