import 'package:country_code_picker/country_code_picker.dart';
import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/loading_button.dart';
import 'package:coupon_app/app/pages/profile/profile_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:coupon_app/app/utils/extensions.dart';
class ProfilePage extends View{
  @override
  State<StatefulWidget> createState() => ProfilePageState();

}


class ProfilePageState extends ViewState<ProfilePage, ProfileController>{
  ProfilePageState() : super(ProfileController(DataAuthenticationRepository()));
  final _formKey = GlobalKey<FormState>();
  @override
  Widget get view => Scaffold(
    appBar: customAppBar(
        title: Text(
          LocaleKeys.updateProfile.tr(),
          style: heading5.copyWith(color: AppColors.primary),
        )),
    key: globalKey,
    body: _body,
  );

  get _body => ControlledWidgetBuilder(builder: (BuildContext context, ProfileController controller){
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
              TextFormField(
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
              ),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              TextFormField(
                controller: controller.lastNameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return LocaleKeys.errorLastNameRequired.tr();
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: LocaleKeys.lastName.tr()),
              ),
             /* SizedBox(
                height: Dimens.spacingMedium,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: controller.emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return LocaleKeys.errorEmailRequired.tr();
                  }
                  if(!value.isValidEmail()){
                    return LocaleKeys.errorInvalidEmail.tr();
                  }
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(MaterialCommunityIcons.email),
                    hintText: LocaleKeys.hintEmail.tr()),
              ),*/
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              TextFormField(
                controller: controller.dobController,
                focusNode: focusNode,
                validator: (value) {
                  if (value.isEmpty) {
                    return LocaleKeys.errorDateOfBirthRequired.tr();
                  }
                  return null;
                },
                onTap: (){
                  focusNode.unfocus();
                  _selectDate(context, controller);
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(MaterialCommunityIcons.calendar),
                    hintText: LocaleKeys.dob.tr()),
              ),
              SizedBox(
                height: Dimens.spacingMedium,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: controller.mobileNumberController,
                validator: (value) {
                  if (value.isEmpty) {
                    return LocaleKeys.errorPhoneRequired.tr();
                  }
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(MaterialCommunityIcons.phone),
                    prefixStyle: heading6,
                    prefix: CountryCodePicker(
                      onChanged: (CountryCode value){
                        controller.countryCode = value.dialCode;
                      },
                      onInit: (CountryCode value){
                        controller.countryCode = value.dialCode;
                      },
                      initialSelection: controller.currentUser != null ? controller.currentUser.country_code  : null,
                      showCountryOnly: false,
                      showFlag: false,
                      showOnlyCountryWhenClosed: false,
                      padding: EdgeInsets.all(12),
                      builder: (CountryCode countryCode){
                        return Padding(
                          padding: const EdgeInsets.only(right: Dimens.spacingMedium),
                          child: Text(countryCode.dialCode, style: bodyTextNormal1,),
                        );
                      },
                    ),
                    hintText: LocaleKeys.phoneNumber.tr()),
              ),

              SizedBox(
                height: Dimens.spacingLarge,
              ),
              SizedBox(
                width: double.infinity,
                child: LoadingButton(
                  isLoading: controller.isLoading,
                  onPressed: () {
                    controller.checkForm({
                      'context' : context,
                      'formKey' : _formKey,
                      'globalKey' : globalKey
                    });
                  },
                  text:  LocaleKeys.updateProfile.tr(),
                ),
              ),
            ],
          ),
        );
      },
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
}