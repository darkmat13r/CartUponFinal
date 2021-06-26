import 'package:country_code_picker/country_code_picker.dart';
import 'package:coupon_app/app/components/loading_button.dart';
import 'package:coupon_app/app/pages/register/register_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:coupon_app/data/repositories/data_nationality_repository.dart';
import 'package:coupon_app/domain/entities/models/Nationality.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:coupon_app/app/utils/extensions.dart';
import 'package:group_radio_button/group_radio_button.dart';

class RegisterPage extends View {
  final String countryCode;
  final String mobileNumber;

  RegisterPage({@required this.countryCode,@required  this.mobileNumber});
  @override
  State<StatefulWidget> createState() => RegisterPageState(countryCode, mobileNumber);
}

class RegisterPageState extends ViewState<RegisterPage, RegisterController> {
  RegisterPageState(countryCode, mobileNumber)
      : super(RegisterController(
            DataAuthenticationRepository(), DataNationalityRepository(),countryCode, mobileNumber));
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;

  @override
  Widget get view => Scaffold(
        key: globalKey,
    appBar: AppBar(elevation: 0,),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                _logo,
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                Text(
                  LocaleKeys.letsGetStarted.tr(args: [LocaleKeys.appName.tr()]),
                  style: heading4,
                ),
                SizedBox(
                  height: Dimens.spacingNormal,
                ),
                Text(
                  LocaleKeys.createAnAccount.tr(),
                  style: bodyTextNormal2,
                ),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                _registerForm(),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                _loginButton
              ],
            ),
          ),
        ),
      );

  final Widget _logo = SizedBox(
      height: 90,
      child: Image.asset(
        Resources.logo,
      ));

  get _loginButton => ControlledWidgetBuilder(
          builder: (BuildContext context, RegisterController controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.haveAnAccount.tr(),
            ),
            TextButton(
              onPressed: () => {controller.login()},
              child: Text(
                LocaleKeys.signIn.tr(),
                style: buttonText.copyWith(color: AppColors.primary),
              ),
            )
          ],
        );
      });

  String selectedGender = "male";
  FocusNode focusNode = new FocusNode();

  Widget _registerForm() {
    return ControlledWidgetBuilder<RegisterController>(
      builder: (BuildContext context, RegisterController controller) {
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
              emailField(controller),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              dateOfBirthField(controller, context),
              /*SizedBox(
                height: Dimens.spacingMedium,
              ),
              genderRadioButtons(controller),*/
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              mobileNumberField(controller),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              passwordField(controller),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              nationalities(controller),
              SizedBox(
                height: Dimens.spacingLarge,
              ),
              signupButton(controller, context),
            ],
          ),
        );
      },
    );
  }

  TextFormField firstNameField(RegisterController controller) {
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

  SizedBox signupButton(RegisterController controller, BuildContext context) {
    return SizedBox(
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
        text: LocaleKeys.signUp.tr(),
      ),
    );
  }

  TextFormField passwordField(RegisterController controller) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      controller: controller.passwordController,
      obscureText: _isPasswordHidden,
      validator: (value) {
        RegExp capitalCharacter = RegExp(r'^(?=.*?[A-Z])');
        RegExp specialCharacter = RegExp(r'^(?=.*?[!@#\$&*~])');
        RegExp numberCharacter = RegExp(r'^(?=.*?[0-9])');
        if (value.isEmpty) {
          return LocaleKeys.errorPasswordRequired.tr();
        }
        if (value.length < 8) {
          return LocaleKeys.errorPasswordLength.tr();
        }
        if (!capitalCharacter.hasMatch(value)) {
          return LocaleKeys.errorCapitalLetter.tr();
        }
        if (!specialCharacter.hasMatch(value)) {
          return LocaleKeys.errorSpecialLetter.tr();
        }
        if (!numberCharacter.hasMatch(value)) {
          return LocaleKeys.errorPasswordNumber.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(MaterialCommunityIcons.lock),
        hintText: LocaleKeys.hintPassword.tr(),
        suffix: InkWell(
            onTap: () {
              setState(() {
                _isPasswordHidden = !_isPasswordHidden;
              });
            },
            child: Icon(_isPasswordHidden ? Feather.eye : Feather.eye_off)),
      ),
    );
  }
  Widget mobileNumberField(RegisterController controller) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.phone,
            enabled: false,
            controller: controller.mobileNumberController,
            decoration: InputDecoration(
                fillColor: AppColors.neutralLightGray,
                labelText: LocaleKeys.phoneNumber.tr(),
                prefixIcon: Icon(MaterialCommunityIcons.phone),
                hintText: LocaleKeys.phoneNumber.tr()),
          ),
        ),
      ],
    );
  }
 /* Widget phoneField(RegisterController controller) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                prefixIcon: Icon(MaterialCommunityIcons.phone),
                hintText: LocaleKeys.phoneNumber.tr()),
          ),
        ),
      ],
    );
  }*/

  TextFormField dateOfBirthField(
      RegisterController controller, BuildContext context) {
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

  TextFormField emailField(RegisterController controller) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: controller.emailController,
      validator: (value) {
        if (value.isEmpty) {
          return LocaleKeys.errorEmailRequired.tr();
        }
        if (!value.isValidEmail()) {
          return LocaleKeys.errorInvalidEmail.tr();
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(MaterialCommunityIcons.email),
          hintText: LocaleKeys.hintEmail.tr()),
    );
  }

  TextFormField lastNameField(RegisterController controller) {
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

  _selectDate(BuildContext context, RegisterController controller) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: controller.dob == null ? DateTime.now() : controller.dob,
      // Refer step 1
      lastDate: DateTime.now(),
      firstDate: DateTime(1880),
    );
    if (picked != null && picked != controller.dob) controller.setDob(picked);
  }

  nationalities(RegisterController controller) {
    return DropdownSearch<Nationality>(
      label: LocaleKeys.nationality.tr(),
      mode: Mode.DIALOG,
      enabled: controller.nationalities != null,
      popupTitle: Padding(
        padding: const EdgeInsets.all(Dimens.spacingMedium),
        child: Text(
          LocaleKeys.nationality.tr(),
          style: heading6,
        ),
      ),
      showSearchBox: true,
      onFind: (String filter) => controller.getFilterNationality(filter),
      itemAsString: (Nationality u) => u.country_name,
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

  titleRadioButtons(RegisterController controller) {
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

  genderRadioButtons(RegisterController controller) {
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

  /*dialCode(RegisterController controller) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.neutralLight,
          borderRadius: BorderRadius.circular(Dimens.cornerRadius),
          border: Border.all(
              color: AppColors.neutralGray, width: Dimens.borderWidth)),
      child: controller.selectedCountry != null
          ? InkWell(
        onTap: (){
          showCountryPicker(controller);
        },
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.spacingMedium,
                    vertical: Dimens.spacingNormal + 4),
                child: Text(
                  (controller.selectedCountry.dial_code.startsWith("+") ?  "" : "+") +controller.selectedCountry.dial_code,
                  style: buttonText.copyWith(color: AppColors.primary),
                ),
              ),
          )
          : Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.spacingMedium,
            vertical: Dimens.spacingNormal + 4),
            child: CountryCodePicker(
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
  void showCountryPicker(RegisterController controller) {
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
                                    (controller.countries[index].dial_code.startsWith("+") ?  "" : "+") +controller.countries[index].dial_code, style: bodyTextMedium2,),
                                  SizedBox(
                                    width: Dimens.spacingNormal,
                                  ),
                                  Expanded(
                                    child: Text(
                                        controller.countries[index].country_name, style: bodyTextMedium2,),
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
  }*/
}
