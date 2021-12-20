import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/loading_button.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/account/address/add/add_address_controller.dart';
import 'package:coupon_app/app/pages/account/address/addresses_view.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:coupon_app/data/repositories/data_address_repository.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/Area.dart';
import 'package:coupon_app/domain/entities/models/Block.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:logger/logger.dart';

class AddAddressPage extends View {
  Address address;
  bool askPersonalDetailsOnly = false;
  bool guest = false;

  AddAddressPage({this.address, bool askPersonalDetailsOnly, bool guest})
      : this.askPersonalDetailsOnly = askPersonalDetailsOnly ?? false,
        this.guest = guest ?? false {
    Logger().e("IsGuest  ${guest}");
  }

  @override
  State<StatefulWidget> createState() => AddAddressPageState(address,
      askPersonalDetailsOnly: askPersonalDetailsOnly, guest: guest);
}

class AddAddressPageState
    extends ViewState<AddAddressPage, AddAddressController> {
  bool askPersonalDetailsOnly = false;
  bool guest = false;

  AddAddressPageState(Address address,
      {bool askPersonalDetailsOnly, bool guest})
      : this.askPersonalDetailsOnly = askPersonalDetailsOnly ?? false,
        this.guest = guest ?? false,
        super(AddAddressController(
            address, DataAddressRepository(), DataAuthenticationRepository(),
            askPersonalDetails: askPersonalDetailsOnly, guest: guest));
  final _formKey = GlobalKey<FormState>();

  final FocusNode areaFocusNode = FocusNode();
  final FocusNode blockFocusNode = FocusNode();

  @override
  Widget get view => Scaffold(
        appBar: customAppBar(
            title: Text(
          guest && askPersonalDetailsOnly
              ? LocaleKeys.guestDetails.tr()
              : (widget.address == null
                  ? LocaleKeys.addAddress.tr()
                  : LocaleKeys.editAddress.tr()),
          style: heading5.copyWith(color: AppColors.primary),
        )),
        key: globalKey,
        body: _body,
      );

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext context, AddAddressController controller) {
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
                askPersonalDetailsOnly == false
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
                askPersonalDetailsOnly == false
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
                askPersonalDetailsOnly == false
                    ? formField(
                        label: LocaleKeys.landmark.tr(),
                        hint: LocaleKeys.landmark.tr(),
                        textEditingController: controller.addressText,
                        validation: (value) {
                          if (value.isEmpty) {
                            return LocaleKeys.errorLandmarkRequired.tr();
                          }
                          return null;
                        })
                    : SizedBox(),
                guest
                    ? formField(
                        label: LocaleKeys.email.tr(),
                        hint: LocaleKeys.hintEmail.tr(),
                        inputType: TextInputType.emailAddress,
                        textEditingController: controller.emailText,
                        validation: (value) {
                          if (value.isEmpty) {
                            return LocaleKeys.errorEmailRequired.tr();
                          }
                          return null;
                        })
                    : SizedBox(),
                guest || controller.currentUser == null
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: Dimens.spacingMedium,
                            bottom: Dimens.spacingNormal),
                        child: Text(
                          LocaleKeys.phone.tr(),
                          style: labelText,
                        ),
                      )
                    : SizedBox(),
                Row(
                  children: [
                    guest || controller.currentUser == null
                        ? Padding(
                            padding: const EdgeInsets.only(
                                right: Dimens.spacingNormal),
                            child: dialCode(controller),
                          )
                        : SizedBox(),
                    Expanded(
                      child: formField(
                          label: guest || controller.currentUser == null
                              ? null
                              : LocaleKeys.phone.tr(),
                          hint: LocaleKeys.hintPhone.tr(),
                          prefix: controller.currentUser != null
                              ? Text(
                            controller.currentUser.country_code,
                            style: bodyTextNormal1,
                          ) : SizedBox(),
                          inputType: TextInputType.phone,
                          textEditingController: controller.phoneText,
                          validation: (value) {
                            if (value.isEmpty) {
                              return LocaleKeys.errorPhoneRequired.tr();
                            }
                            return null;
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                guest == false
                    ? CheckboxListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text(
                          LocaleKeys.txtDefaultAddress.tr(),
                          style: captionNormal1,
                        ),
                        value: controller.isDefault,
                        onChanged: (newValue) {
                          setState(() {
                            controller.isDefault = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      )
                    : SizedBox(),
                SizedBox(
                  height: Dimens.spacingLarge,
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

  _blockAndArea(AddAddressController controller) {
    return askPersonalDetailsOnly == false
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

  dialCode(AddAddressController controller) {
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

  void showCountryPicker(AddAddressController controller) {
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

  Widget formField(
      {String label,
      Widget prefix,
      String hint,
      Controller controller,
      Function validation,
      FocusNode focusNode,
      TextInputType inputType,
      TextEditingController textEditingController,
      Function onTap}) {
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

  showBlockDialog(AddAddressController controller) {
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
                                controller.isLocaleEnglish() ? block.block_name : block.block_name_ar,
                                style: bodyTextNormal1.copyWith(
                                    color: AppColors.neutralGray),
                              ),
                            ));
                      })),
            ),
          );
        });
  }

  showAreaDialog(AddAddressController controller) {
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
                                controller.isLocaleEnglish() ? area.area_name : area.area_name_ar,
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
          builder: (BuildContext context, AddAddressController controller) {
        return LoadingButton(
            isLoading: controller.isLoading,
            onPressed: () {
              controller.checkForm({
                'context': context,
                'formKey': _formKey,
                'globalKey': globalKey
              });
            },
            text: guest ? LocaleKeys.submit.tr() :(widget.address == null ?LocaleKeys.addAddress.tr() : LocaleKeys.editAddress.tr()));
      });
}
