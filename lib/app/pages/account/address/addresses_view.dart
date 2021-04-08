import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/loading_button.dart';
import 'package:coupon_app/app/components/rounded_box.dart';
import 'package:coupon_app/app/pages/account/address/addresses_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:coupon_app/data/repositories/data_address_repository.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AddressesPage extends View {
  @override
  State<StatefulWidget> createState() => AddressesPageState();
}

class AddressesPageState extends ViewState<AddressesPage, AddressesController> {
  AddressesPageState() : super(AddressesController(DataAddressRepository()));

  @override
  Widget get view => Scaffold(
        appBar: customAppBar(
            title: Text(
          LocaleKeys.address.tr(),
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
            _addAddress,
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            SizedBox(
              height: Dimens.spacingMedium,
            ),
          ],
        ),
      );

  get _addresses => ControlledWidgetBuilder(
          builder: (BuildContext context, AddressesController controller) {
        return ListView.builder(
            itemCount:
                controller.addresses != null ? controller.addresses.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return _buildAddressCard(controller, controller.addresses[index]);
            });
      });

  get _addAddress => ControlledWidgetBuilder(
          builder: (BuildContext context, AddressesController controller) {
        return RaisedButton(
            elevation: 0,
            color: AppColors.neutralLightGray.withAlpha(120),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),
            onPressed: () {
              controller.addAddress();
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: Dimens.spacingNormal),
              child: Column(
                children: [
                  Icon(
                    MaterialCommunityIcons.plus_circle,
                    color: AppColors.neutralGray,
                  ),
                  Text(
                    LocaleKeys.addAddress.tr(),
                    style: buttonText.copyWith(
                      color: AppColors.neutralGray,
                    ),
                  )
                ],
              ),
            ));
      });

  _buildAddressCard(AddressesController controller, Address address) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
            left: Dimens.spacingMedium,
            right: Dimens.spacingMedium,
            top: Dimens.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${address.floor_flat}, ${address.block} , ${address.building}}",
              style: heading5,
            ),
            SizedBox(
              height: Dimens.spacingNormal,
            ),
            Text(
              "${address.area} ${address.address}",
              style: bodyTextNormal1.copyWith(color: AppColors.neutralGray),
            ),
            SizedBox(
              height: Dimens.spacingNormal,
            ),
            Text(
              address.phone_no,
              style: bodyTextNormal1.copyWith(color: AppColors.neutralGray),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    LocaleKeys.edit.tr(),
                    style: buttonText.copyWith(color: AppColors.yellow),
                  ),
                ),
                SizedBox(
                  width: Dimens.spacingMedium,
                ),
                TextButton(
                  onPressed: () {
                    controller.delete(address);
                  },
                  child: Text(
                    LocaleKeys.delete.tr(),
                    style: buttonText.copyWith(color: AppColors.error),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
