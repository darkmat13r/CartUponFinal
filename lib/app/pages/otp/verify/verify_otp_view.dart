import 'package:coupon_app/app/components/loading_button.dart';
import 'package:coupon_app/app/pages/otp/verify/verify_otp_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/repositories/data_verification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpPage extends View {
  final String countryCode;
  final String mobileNumber;
  final bool returnResult;
  VerifyOtpPage(this.countryCode, this.mobileNumber,{this.returnResult});

  @override
  State<StatefulWidget> createState() =>
      _VerifyOtpPageState(this.countryCode, this.mobileNumber, returnResult: returnResult);
}

class _VerifyOtpPageState
    extends ViewState<VerifyOtpPage, VerifyOtpController> {
  _VerifyOtpPageState(String countryCode, String mobileNumber, {bool returnResult})
      : super(VerifyOtpController(
            countryCode, mobileNumber, DataVerificationRepository(), returnResult : returnResult));

  @override
  Widget get view => Scaffold(
        key: globalKey,
        appBar: AppBar(
          elevation: 0,
        ),
        body: _body,
      );
  final _formKey = GlobalKey<FormState>();
  final Widget _logo = SizedBox(
      height: 90,
      child: Image.asset(
        Resources.logo,
      ));

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext context, VerifyOtpController controller) {
        return ListView(
          children: [
            _logo,
            SizedBox(
              height: Dimens.spacingLarge,
            ),
            Padding(
              padding: const EdgeInsets.all(Dimens.spacingMedium),
              child: Column(
                children: [
                  Text(
                    LocaleKeys.otpVerification.tr(),
                    style: heading4.copyWith(color: AppColors.neutralDark),
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  Text(
                    LocaleKeys.fmtEnterOtp
                        .tr(args: [controller.getSelectedMobileNumber()]),
                    textAlign: TextAlign.center,
                    style: captionLarge1.copyWith(color: AppColors.neutralGray),
                  ),
                  SizedBox(
                    height: Dimens.spacingLarge,
                  ),
                  SizedBox(
                    height: Dimens.spacingLarge,
                  ),
                  Form(
                    key: _formKey,
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      validator: (v) {
                        if (v.length < 6) {
                          return LocaleKeys.errorOtpLength.tr();
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,

                        activeFillColor:
                            controller.hasError ? Colors.blue.shade100 : Colors.white,
                      ),
                      onChanged: (value) {},
                      controller: controller.otpController,
                    ),
                  ),
                  SizedBox(
                    height: Dimens.spacingLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.dontReceiveOtp.tr(),
                        style: captionLarge1.copyWith(
                            color: AppColors.neutralGray),
                      ),
                      InkWell(
                        onTap: () {
                          controller.resendOtp();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(Dimens.spacingNormal),
                          child: Text(
                            LocaleKeys.resendOtp.tr(),
                            style: buttonText.copyWith(color: AppColors.accent),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dimens.spacingLarge,
                  ),
                  SizedBox(
                    height: Dimens.spacingLarge,
                  ),
                  verifyOtp(controller, context)
                ],
              ),
            )
          ],
        );
      });

  SizedBox verifyOtp(VerifyOtpController controller, BuildContext context) {
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
        text: LocaleKeys.verifyOtp.tr(),
      ),
    );
  }
}
