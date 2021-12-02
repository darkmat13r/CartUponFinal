import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/pages/contact/contact_us_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/repositories/data_home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ContactUsPage extends View{
  @override
  State<StatefulWidget> createState() => _ContactUsPageState();

}

class _ContactUsPageState extends ViewState<ContactUsPage, ContactUsController>{
  _ContactUsPageState() : super(ContactUsController(DataHomeRepository()));

  @override
  Widget get view => Scaffold(
    appBar: customAppBar(title: Text(LocaleKeys.contactUs.tr(), style: heading5.copyWith(color: AppColors.primary),)),
    body: _body,
  );

  get _body => ControlledWidgetBuilder(builder: (BuildContext context, ContactUsController controller){
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.officeAddress.tr(), style: heading5,),
              SizedBox(
                height: 16,
              ),
              ListTile(
                title: Text(controller.webSetting?.address ?? ""),
                leading: Icon(Feather.map_pin, color: AppColors.accent,),
              ),
              ListTile(
                onTap: (){
                  controller.openCall(controller.webSetting?.support_phoneno ?? "");
                },
                title: Text(controller.webSetting?.support_phoneno ?? ""),
                leading: Icon(Feather.phone, color: AppColors.accent,),
              ),
              ListTile(
                onTap: (){
                  controller.openMail(controller.webSetting?.support_email ?? "");
                },
                title: Text(controller.webSetting?.support_email ?? ""),
                leading: Icon(Feather.mail, color: AppColors.accent,),
              )
            ],
          ),
        ),
      ],
    );
  });
}