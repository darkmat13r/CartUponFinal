import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/loading_button.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/account/address/add/add_address_controller.dart';
import 'package:coupon_app/app/pages/account/address/addresses_view.dart';
import 'package:coupon_app/app/pages/account/guest/guest_info_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:coupon_app/data/repositories/data_address_repository.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:coupon_app/data/repositories/data_order_repository.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/Area.dart';
import 'package:coupon_app/domain/entities/models/Block.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:logger/logger.dart';

class GuestInfoPage extends View {
  final String countryCode;
  final String mobileNumber;
  final int payMode;
  final bool onlyCoupon;
  final bool useWallet;

  GuestInfoPage(
      {this.countryCode, this.mobileNumber, this.payMode, this.onlyCoupon, this.useWallet}) {}

  @override
  State<StatefulWidget> createState() => _GuestInfoPageState(
      mobileNumber: mobileNumber,
      countryCode: countryCode,
      payMode: payMode,
      onlyCoupon: onlyCoupon);
}

class _GuestInfoPageState
    extends ViewState<GuestInfoPage, GuestInfoController> {
  final String countryCode;
  final String mobileNumber;
  final int payMode;
  final bool onlyCoupon;
  final bool useWallet;

  _GuestInfoPageState(
      {this.countryCode, this.mobileNumber, this.payMode, this.onlyCoupon, this.useWallet})
      : super(GuestInfoController(
          DataAddressRepository(),
      DataOrderRepository(),
      DataAuthenticationRepository(),
      mobileNumber: mobileNumber,
      countryCode: countryCode,
      payMode: payMode,
      onlyCoupon: onlyCoupon,
      useWallet: useWallet
        ));
  final _formKey = GlobalKey<FormState>();

  final FocusNode areaFocusNode = FocusNode();
  final FocusNode blockFocusNode = FocusNode();

  @override
  Widget get view => Scaffold(
        appBar: customAppBar(
            title: Text(
          LocaleKeys.guestDetails.tr(),
          style: heading5.copyWith(color: AppColors.primary),
        )),
        key: globalKey,
        body: _body,
      );

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext context, GuestInfoController controller) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.spacingMedium),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                formField(
                    label: LocaleKeys.firstName.tr(),
                    hint: LocaleKeys.hintFirstName.tr(),
                    textEditingController: controller.firstNameText,
                    validation: (value) {
                      if (value.isEmpty) {
                        return LocaleKeys.errorFirstNameRequired.tr();
                      }
                      return null;
                    }),
                formField(
                    label: LocaleKeys.lastName.tr(),
                    hint: LocaleKeys.hintLastName.tr(),
                    textEditingController: controller.lastNameText,
                    validation: (value) {
                      if (value.isEmpty) {
                        return LocaleKeys.errorLastNameRequired.tr();
                      }
                      return null;
                    }),
                _blockAndArea(controller),
                onlyCoupon == false
                    ? formField(
                        label: LocaleKeys.floorFlat.tr(),
                        hint: LocaleKeys.hintFlat.tr(),
                        textEditingController: controller.flatText,
                        validation: (value) {
                          if (value.isEmpty) {
                            return LocaleKeys.errorFloorFlatRequired.tr();
                          }
                          return null;
                        })
                    : SizedBox(),
                onlyCoupon == false
                    ? formField(
                        label: LocaleKeys.building.tr(),
                        hint: LocaleKeys.hintBuilding.tr(),
                        textEditingController: controller.buildingText,
                        validation: (value) {
                          if (value.isEmpty) {
                            return LocaleKeys.errorBuildingRequired.tr();
                          }
                          return null;
                        })
                    : SizedBox(),
                onlyCoupon == false
                    ? formField(
                        label: LocaleKeys.address.tr(),
                        hint: LocaleKeys.hintAddress.tr(),
                        textEditingController: controller.addressText,
                        validation: (value) {
                          if (value.isEmpty) {
                            return LocaleKeys.errorAddressRequired.tr();
                          }
                          return null;
                        })
                    : SizedBox(),
                formField(
                        label: LocaleKeys.email.tr(),
                        hint: LocaleKeys.hintEmail.tr(),
                        inputType: TextInputType.emailAddress,
                        textEditingController: controller.emailText,
                        validation: (value) {
                          if (value.isEmpty) {
                            return LocaleKeys.errorEmailRequired.tr();
                          }
                          return null;
                        }),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                mobileNumberField(controller),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),

                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                _addAddress,
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
                SizedBox(
                  height: Dimens.spacingLarge,
                ),
              ],
            ),
          ),
        );
      });
  Widget mobileNumberField(GuestInfoController controller) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.phone,
            enabled: false,
            controller: controller.phoneText,
            /*validator: (value) {
              if (value.isEmpty) {
                return LocaleKeys.errorPhoneRequired.tr();
              }
              return null;
            },*/
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
  _blockAndArea(GuestInfoController controller) {
    return onlyCoupon ==  false
        ? Row(
            children: [
              Expanded(
                child: formField(
                    label: LocaleKeys.area.tr(),
                    hint: LocaleKeys.hintArea.tr(),
                    textEditingController: controller.areaText,
                    focusNode: areaFocusNode,
                    onTap: () {
                      areaFocusNode.unfocus();
                      if (controller.areas != null) {
                        showAreaDialog(controller);
                      }
                    },
                    validation: (value) {
                      if (value.isEmpty) {
                        return LocaleKeys.errorLastNameRequired.tr();
                      }
                      return null;
                    }),
              ),
              SizedBox(
                width: Dimens.spacingNormal,
              ),
              Expanded(
                child: formField(
                    label: LocaleKeys.block.tr(),
                    hint: LocaleKeys.hintBlock.tr(),
                    focusNode: blockFocusNode,
                    onTap: () {
                      blockFocusNode.unfocus();
                      if (controller.blocks != null) {
                        showBlockDialog(controller);
                      }
                    },
                    textEditingController: controller.blockText,
                    validation: (value) {
                      if (value.isEmpty) {
                        return LocaleKeys.errorLastNameRequired.tr();
                      }
                      return null;
                    }),
              ),
            ],
          )
        : SizedBox();
  }


  Widget formField(
      {String label,
      Widget prefix,
      String hint,
      Controller controller,
      Function validation,
      FocusNode focusNode,
      TextInputType inputType,
      TextEditingController textEditingController,
      Function onTap,bool isActive}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: label != null ? Dimens.spacingMedium : 0,
        ),
        label != null
            ? Text(
                label,
                style: labelText,
              )
            : SizedBox(),
        SizedBox(
          height: label != null ? Dimens.spacingNormal : 0,
        ),
        TextFormField(
          enabled: isActive,
          keyboardType: inputType,
          focusNode: focusNode,
          onTap: onTap,
          controller: textEditingController,
          validator: validation,
          decoration: InputDecoration(
              hintText: hint,
              prefix: Padding(
                padding: EdgeInsets.only(right: Dimens.spacingNormal),
                child: prefix,
              )),
        )
      ],
    );
  }

  showBlockDialog(GuestInfoController controller) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              LocaleKeys.chooseBlock.tr(),
              style: heading6,
            ),
            content: Container(
              width: double.maxFinite,
              height: 320,
              child: StateView(
                  controller.blocks != null && controller.blocks.length > 0
                      ? EmptyState.CONTENT
                      : EmptyState.EMPTY,
                  ListView.builder(
                      itemCount: controller.blocks.length,
                      itemBuilder: (BuildContext context, int index) {
                        Block block = controller.blocks[index];
                        return InkWell(
                            onTap: () {
                              controller.onSelectBlock(block);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimens.spacingNormal),
                              child: Text(
                                block.block_name,
                                style: bodyTextNormal1.copyWith(
                                    color: AppColors.neutralGray),
                              ),
                            ));
                      })),
            ),
          );
        });
  }

  showAreaDialog(GuestInfoController controller) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              LocaleKeys.chooseArea.tr(),
              style: heading6,
            ),
            content: Container(
              width: double.maxFinite,
              height: 320,
              child: StateView(
                  controller.areas != null && controller.areas.length > 0
                      ? EmptyState.CONTENT
                      : EmptyState.EMPTY,
                  ListView.builder(
                      itemCount: controller.areas.length,
                      itemBuilder: (BuildContext context, int index) {
                        Area area = controller.areas[index];
                        return InkWell(
                            onTap: () {
                              controller.onSelectArea(area);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimens.spacingNormal),
                              child: Text(
                                area.area_name,
                                style: bodyTextNormal1.copyWith(
                                    color: AppColors.neutralGray),
                              ),
                            ));
                      })),
            ),
          );
        });
  }

  get _addAddress => ControlledWidgetBuilder(
          builder: (BuildContext context, GuestInfoController controller) {
        return LoadingButton(
            isLoading: controller.isLoading,
            onPressed: () {
              controller.checkForm({
                'context': context,
                'formKey': _formKey,
                'globalKey': globalKey
              });
            },
            text: LocaleKeys.completeCheckout.tr());
      });
}
