import 'package:country_code_picker/country_code_picker.dart';
import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/loading_button.dart';
import 'package:coupon_app/app/pages/profile/profile_controller.dart';
import 'package:coupon_app/app/pages/register/register_controller.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:coupon_app/data/repositories/data_nationality_repository.dart';
import 'package:coupon_app/domain/entities/models/Nationality.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:coupon_app/app/utils/extensions.dart';
import 'package:group_radio_button/group_radio_button.dart';

class ProfilePage extends View {
  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends ViewState<ProfilePage, ProfileController> {
  ProfilePageState()
      : super(ProfileController(
            DataAuthenticationRepository(), DataNationalityRepository()));
  final _formKey = GlobalKey<FormState>();

  @override
  Widget get view => ControlledWidgetBuilder(
          builder: (BuildContext ctx, ProfileController controller) {
        return WillPopScope(
            child: Scaffold(
              appBar: customAppBar(
                  title: Text(
                LocaleKeys.updateProfile.tr(),
                style: heading5.copyWith(color: AppColors.primary),
              )),
              key: globalKey,
              body: _body,
            ),
            onWillPop: controller.onWillPop);
      });

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext context, ProfileController controller) {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimens.spacingMedium),
              child: _registerForm(),
            )
          ],
        );
      });
  FocusNode focusNode = new FocusNode();

  Widget _registerForm() {
    return ControlledWidgetBuilder<ProfileController>(
      builder: (BuildContext context, ProfileController controller) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleRadioButtons(controller),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              firstNameField(controller),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              lastNameField(controller),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              dobField(controller, context),
              /*SizedBox(
                height: Dimens.spacingMedium,
              ),
              emailField(controller),
              SizedBox(
                height: Dimens.spacingMedium,
              ),,*/
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              dialCode(controller),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              nationalities(controller),
              SizedBox(
                height: Dimens.spacingLarge,
              ),
              SizedBox(
                width: double.infinity,
                child: LoadingButton(
                  isLoading: controller.isLoading,
                  onPressed: () {
                    controller.checkForm({
                      'context': context,
                      'formKey': _formKey,
                      'globalKey': globalKey
                    });
                  },
                  text: LocaleKeys.updateProfile.tr(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  TextFormField firstNameField(ProfileController controller) {
    return TextFormField(
      controller: controller.firstNameController,
      validator: (value) {
        if (value.isEmpty) {
          return LocaleKeys.errorFirstNameRequired.tr();
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(MaterialCommunityIcons.account),
          hintText: LocaleKeys.firstName.tr()),
    );
  }

  TextFormField lastNameField(ProfileController controller) {
    return TextFormField(
      controller: controller.lastNameController,
      validator: (value) {
        if (value.isEmpty) {
          return LocaleKeys.errorLastNameRequired.tr();
        }
        return null;
      },
      decoration: InputDecoration(hintText: LocaleKeys.lastName.tr()),
    );
  }

  TextFormField dobField(ProfileController controller, BuildContext context) {
    return TextFormField(
      controller: controller.dobController,
      focusNode: focusNode,
      validator: (value) {
        if (value.isEmpty) {
          return LocaleKeys.errorDateOfBirthRequired.tr();
        }
        return null;
      },
      onTap: () {
        focusNode.unfocus();
        _selectDate(context, controller);
      },
      decoration: InputDecoration(
          prefixIcon: Icon(MaterialCommunityIcons.calendar),
          hintText: LocaleKeys.dob.tr()),
    );
  }

  Widget mobileNumberField(ProfileController controller) {
    return Row(
      children: [
        dialCode(controller),
       /* Expanded(
          child: TextFormField(
            keyboardType: TextInputType.phone,
            enabled: false,
            controller: controller.mobileNumberController,
            *//*validator: (value) {
              if (value.isEmpty) {
                return LocaleKeys.errorPhoneRequired.tr();
              }
              return null;
            },*//*
            decoration: InputDecoration(
                // fillColor: AppColors.neutralLightGray,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.neutralLightGray,
                      width: Dimens.borderWidth),
                ),
                labelText: LocaleKeys.phoneNumber.tr(),
                prefixIcon: Icon(MaterialCommunityIcons.phone),
                hintText: LocaleKeys.phoneNumber.tr()),
          ),
        ),*/
      ],
    );
  }

  Widget emailField(ProfileController controller) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            enabled: false,
            controller: controller.emailController,
            decoration: InputDecoration(
                // fillColor: AppColors.neutralLightGray,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.neutralLightGray,
                      width: Dimens.borderWidth),
                ),
                labelText: LocaleKeys.email.tr(),
                prefixIcon: Icon(MaterialCommunityIcons.email),
                hintText: LocaleKeys.email.tr()),
          ),
        ),
      ],
    );
  }

  dialCode(ProfileController controller) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          // color: AppColors.neutralLightGray,
          borderRadius: BorderRadius.circular(Dimens.cornerRadius),
          border: Border.all(
              color: AppColors.neutralLightGray, width: Dimens.borderWidth)),
      child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.spacingMedium,
                  vertical: Dimens.spacingNormal + 4),
              child: CountryCodePicker(
                initialSelection: controller.countryCode,
                onChanged: (CountryCode value) {
                  controller.countryCode = value.dialCode;
                },
                onInit: (CountryCode value) {
                  controller.countryCode = value.dialCode;
                },
                showCountryOnly: false,
                showFlag: false,
                showOnlyCountryWhenClosed: false,
                padding: EdgeInsets.all(12),
                builder: (CountryCode countryCode) {
                  return Padding(
                    padding: const EdgeInsets.only(right: Dimens.spacingMedium),
                    child: Text(
                      countryCode.dialCode,
                      style: bodyTextNormal1,
                    ),
                  );
                },
              ),
            ),
    );
  }

  nationalities(ProfileController controller) {
    return DropdownSearch<Nationality>(
      label: LocaleKeys.nationality.tr(),
      mode: Mode.DIALOG,
      enabled: controller.nationalities != null,
      selectedItem: controller.nationality,
      popupTitle: Padding(
        padding: const EdgeInsets.all(Dimens.spacingMedium),
        child: Text(
          LocaleKeys.nationality.tr(),
          style: heading6,
        ),
      ),
      showSearchBox: true,
      onFind: (String filter) => controller.getFilterNationality(filter),
      itemAsString: (Nationality u) => Config().locale.languageCode == "en"
          ? u.country_name
          : u.country_name_ar,
      onChanged: (Nationality data) => controller.setNationality(data),
    );
  }

  static var titles = [
    LocaleKeys.titleMr.tr(),
    LocaleKeys.titleMs.tr(),
    LocaleKeys.titleMrs.tr()
  ];
  static var genders = [
    LocaleKeys.genderMale.tr(),
    LocaleKeys.genderFemale.tr()
  ];

  titleRadioButtons(ProfileController controller) {
    return RadioGroup<int>.builder(
      groupValue: controller.title,
      direction: Axis.horizontal,
      spacebetween: 10,
      horizontalAlignment: MainAxisAlignment.start,
      onChanged: (value) => {controller.setTitle(value)},
      items: [0, 1, 2],
      itemBuilder: (item) => RadioButtonBuilder(
        titles[item],
      ),
    );
  }

  genderRadioButtons(ProfileController controller) {
    return RadioGroup<int>.builder(
      groupValue: controller.gender,
      direction: Axis.horizontal,
      onChanged: (value) => {controller.setGender(value)},
      items: [0, 1],
      spacebetween: 10,
      horizontalAlignment: MainAxisAlignment.start,
      itemBuilder: (item) => RadioButtonBuilder(
        genders[item],
      ),
    );
  }

  _selectDate(BuildContext context, ProfileController controller) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: controller.dob == null ? DateTime.now() : controller.dob,
      // Refer step 1
      lastDate: DateTime.now(),
      firstDate: DateTime(1880),
    );
    if (picked != null && picked != controller.dob) controller.setDob(picked);
  }

  void showCountryPicker(ProfileController controller) {
    return;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              LocaleKeys.chooseCountry.tr(),
              style: heading5,
            ),
            content: SingleChildScrollView(
              child: Material(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        controller.countries != null
                            ? controller.countries.length
                            : 0,
                        (index) => InkWell(
                              onTap: () {
                                controller.setSelectedCountry(
                                    controller.countries[index]);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(Dimens.spacingNormal),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Text(
                                        (controller.countries[index].dial_code
                                                    .startsWith("+")
                                                ? ""
                                                : "+") +
                                            controller
                                                .countries[index].dial_code,
                                        style: bodyTextMedium2,
                                      ),
                                      SizedBox(
                                        width: Dimens.spacingNormal,
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller
                                              .countries[index].country_name,
                                          style: bodyTextMedium2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))),
              ),
            ),
          );
        });
  }
}
