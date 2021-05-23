import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/pages/setting/settings_controller.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/repositories/data_country_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SettingsPage extends View {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ViewState<SettingsPage, SettingsController> {
  _SettingsPageState() : super(SettingsController(DataCountryRepository()));

  @override
  Widget get view =>
      Scaffold(
        key: globalKey,
        appBar: customAppBar(
            title: Text(
              LocaleKeys.settings.tr(),
              style: heading5.copyWith(color: AppColors.primary),
            )),
        body: _body,
      );

  get _body =>
      ListView(
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(Dimens.spacingMedium),
                child: Text(
                  LocaleKeys.youAreIn.tr(),
                  style: bodyTextMedium1.copyWith(color: AppColors.neutralGray),
                ),
              ),
              _countryPicker,
              Padding(
                padding: const EdgeInsets.all(Dimens.spacingMedium),
                child: Text(
                  LocaleKeys.yourPreferredLanguageId.tr(),
                  style: bodyTextMedium1.copyWith(color: AppColors.neutralGray),
                ),
              ),
              Container(
                color: AppColors.neutralLight,
                child:               _languagePicker
                ,
              ),
              saveButton()
            ],
          )
        ],
      );

  get _countryPicker =>
      ControlledWidgetBuilder(
          builder: (BuildContext context, SettingsController controller) {
            return Container(
              color: AppColors.neutralLight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.spacingMedium,
                    vertical: Dimens.spacingSmall),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        controller.selectedCountry != null
                            ? controller.selectedCountry.country_name
                            : "-",
                        style:
                        bodyTextMedium1.copyWith(color: AppColors.neutralDark),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          showCountryPicker(controller);
                        },
                        child: Text(
                          LocaleKeys.change.tr(),
                          style: buttonText.copyWith(color: AppColors.primary),
                        ))
                  ],
                ),
              ),
            );
          });

  get _languagePicker =>
     ControlledWidgetBuilder(builder: (BuildContext context,  SettingsController controller){
       return  Column(
         children: [
           ListTile(
             onTap: (){
                controller.setLanguage("en");
             },
             leading: _createLanguage("EN"),
             title: Text(LocaleKeys.languageEnglish.tr()),
             trailing:  controller.languageCode.toLowerCase() == "en" ? Icon(
               Feather.check_circle, color: AppColors.accent,) : SizedBox(),
           ),
           ListTile(
             onTap: (){
               controller.setLanguage("ar");
             },
             leading: _createLanguage("AR"),
             title: Text(LocaleKeys.languageArabic.tr()),
             trailing: controller.languageCode.toLowerCase() == "ar" ? Icon(
               Feather.check_circle, color: AppColors.accent,) : SizedBox(),
           )
         ],
       );
     });

  _createLanguage(language) {
    Container(
      width: 48,
      height: 48,
      child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(language),
          )),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48),
        border: Border.all(
            color: AppColors.neutralGray,
            width: 2),
      ),
    );
  }

  void showCountryPicker(SettingsController controller) {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Choose Country", style: heading5,),
        content: Container(
          height: 300.0,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  controller.setSelectedCountry(controller.countries[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.spacingNormal),
                  child: Text(controller.countries[index].country_name),
                ),
              );
            },
            itemCount: controller.countries != null ? controller.countries
                .length : 0,),
        ),);
    });
  }

  saveButton() {
    return ControlledWidgetBuilder(builder: (BuildContext context, SettingsController controller){
      return Padding(
        padding: const EdgeInsets.all(Dimens.spacingMedium),
        child: SizedBox(
          width: double.infinity,
            child: ElevatedButton(onPressed: (){
              controller.save();
            }, child: Text(LocaleKeys.saveSettings.tr()))),
      ) ;
    });
  }
}
