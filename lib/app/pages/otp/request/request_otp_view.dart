import 'package:country_code_picker/country_code_picker.dart';
import 'package:coupon_app/app/components/loading_button.dart';
import 'package:coupon_app/app/pages/otp/request/request_otp_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/repositories/data_verification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class RequestOtpPage extends View {
  final bool returnResult;

  RequestOtpPage({this.returnResult});

  @override
  State<StatefulWidget> createState() => _RequestOtpPageState( returnResult: returnResult);
}

class _RequestOtpPageState
    extends ViewState<RequestOtpPage, RequestOtpController> {
  _RequestOtpPageState( {bool returnResult}) : super(RequestOtpController(DataVerificationRepository(),returnResult : returnResult));
  final _formKey = GlobalKey<FormState>();

  @override
  Widget get view => Scaffold(
        key: globalKey,
        appBar: AppBar(
          elevation: 0,
        ),
        body: _body,
      );

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext context, RequestOtpController controller) {
        return ListView(
          children: [
            _logo,
            SizedBox(
              height: Dimens.spacingLarge,
            ),
            Padding(
              padding: const EdgeInsets.all(Dimens.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.otpVerification.tr(),
                    textAlign: TextAlign.center,
                    style: heading4.copyWith(color: AppColors.neutralDark),
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  Text(
                    LocaleKeys.otpRequestTitle.tr(),
                    textAlign: TextAlign.center,
                    style: captionLarge1.copyWith(color: AppColors.neutralGray),
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Dimens.spacingLarge,
                          ),
                          phoneField(controller),
                          SizedBox(
                            height: Dimens.spacingLarge,
                          ),
                          SizedBox(
                            height: Dimens.spacingLarge,
                          ),
                          requestOtp(controller, context)
                        ],
                      ))
                ],
              ),
            )
          ],
        );
      });

  Widget phoneField(RequestOtpController controller) {
    return Row(
      children: [
        dialCode(controller),
        SizedBox(
          width: Dimens.spacingNormal,
        ),
        Expanded(
          child: TextFormField(
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
                hintText: LocaleKeys.phoneNumber.tr()),
          ),
        ),
      ],
    );
  }

  SizedBox requestOtp(RequestOtpController controller, BuildContext context) {
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
        text: LocaleKeys.getOtp.tr(),
      ),
    );
  }

  dialCode(RequestOtpController controller) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.neutralLight,
          borderRadius: BorderRadius.circular(Dimens.cornerRadius),
          border: Border.all(
              color: AppColors.neutralGray, width: Dimens.borderWidth)),
      child: controller.selectedCountry != null
          ? InkWell(
              onTap: () {
                showCountryPicker(controller);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.spacingMedium,
                    vertical: Dimens.spacingNormal + 4),
                child: Text(
                  (controller.selectedCountry.dial_code.startsWith("+")
                          ? ""
                          : "+") +
                      controller.selectedCountry.dial_code,
                  style: buttonText.copyWith(color: AppColors.primary),
                ),
              ),
            )
          : SizedBox(),

    );
  }

  void showCountryPicker(RequestOtpController controller) {
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

  final Widget _logo = SizedBox(
      height: 90,
      child: Image.asset(
        Resources.logo,
      ));
}
