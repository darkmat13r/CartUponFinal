import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/loading_button.dart';
import 'package:coupon_app/app/pages/account/address/add/add_address_controller.dart';
import 'package:coupon_app/app/pages/account/address/addresses_view.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AddAddressPage extends View {
  @override
  State<StatefulWidget> createState() => AddAddressPageState();
}

class AddAddressPageState
    extends ViewState<AddAddressPage, AddAddressController> {
  AddAddressPageState() : super(AddAddressController());

  @override
  Widget get view => Scaffold(
    appBar: customAppBar(
        title: Text(
          LocaleKeys.addAddress.tr(),
          style: heading5.copyWith(color: AppColors.primary),
        )),
        key: globalKey,
        body: _body,
      );

  get _body => Padding(
        padding: const EdgeInsets.all(Dimens.spacingMedium),
        child: ListView(
          shrinkWrap: true,
          children: [
            formField(label: LocaleKeys.firstName.tr(), hint: ""),
            formField(label: LocaleKeys.lastName.tr(), hint: ""),
            formField(label: LocaleKeys.streetAddress.tr(), hint: ""),
            formField(label: LocaleKeys.streetAddressOption.tr(), hint: ""),
            formField(label: LocaleKeys.city.tr(), hint: ""),
            formField(label: LocaleKeys.state.tr(), hint: ""),
            formField(label: LocaleKeys.zipCode.tr(), hint: ""),
            formField(label: LocaleKeys.phone.tr(), hint: ""),
            SizedBox(
              height: Dimens.spacingLarge,
            ),
            _addAddress
          ],
        ),
      );

  Widget formField(
      {String label,  String hint, Controller controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Dimens.spacingMedium,
        ),
        Text(
          label,
          style: labelText,
        ),
        SizedBox(
          height: Dimens.spacingNormal,
        ),
        TextFormField(
          decoration:
              InputDecoration( hintText: hint),
        )
      ],
    );
  }

  get _addAddress => ControlledWidgetBuilder(
      builder: (BuildContext context, AddAddressController controller) {
        return LoadingButton(onPressed: (){
          controller.addAddress();
        }, text: LocaleKeys.changePassword.tr());
      });
}
