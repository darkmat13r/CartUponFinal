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
import 'package:coupon_app/domain/entities/models/Area.dart';
import 'package:coupon_app/domain/entities/models/Block.dart';
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
  AddAddressPageState()
      : super(AddAddressController(
            DataAddressRepository(), DataAuthenticationRepository()));
  final _formKey = GlobalKey<FormState>();

  final FocusNode areaFocusNode = FocusNode();
  final FocusNode blockFocusNode = FocusNode();

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
                Row(
                  children: [
                    Expanded(
                      child: formField(
                          label: LocaleKeys.area.tr(),
                          hint: LocaleKeys.hintArea.tr(),
                          textEditingController: controller.areaText,
                          focusNode: areaFocusNode,
                          onTap: () {
                            areaFocusNode.unfocus();
                            if(controller.areas != null ){
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
                           if(controller.blocks != null){
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
                ),
                formField(
                    label: LocaleKeys.floorFlat.tr(),
                    hint: LocaleKeys.hintFlat.tr(),
                    textEditingController: controller.flatText,
                    validation: (value) {
                      if (value.isEmpty) {
                        return LocaleKeys.errorFloorFlatRequired.tr();
                      }
                      return null;
                    }),
                formField(
                    label: LocaleKeys.building.tr(),
                    hint: LocaleKeys.hintBuilding.tr(),
                    textEditingController: controller.buildingText,
                    validation: (value) {
                      if (value.isEmpty) {
                        return LocaleKeys.errorBuildingRequired.tr();
                      }
                      return null;
                    }),
                formField(
                    label: LocaleKeys.address.tr(),
                    hint: LocaleKeys.hintAddress.tr(),
                    textEditingController: controller.addressText,
                    validation: (value) {
                      if (value.isEmpty) {
                        return LocaleKeys.errorAddressRequired.tr();
                      }
                      return null;
                    }),
                formField(
                    label: LocaleKeys.phone.tr(),
                    hint: LocaleKeys.hintPhone,
                    inputType: TextInputType.phone,
                    prefix: Text(
                      controller.currentUser.country_code,
                      style: bodyTextNormal1,
                    ),
                    textEditingController: controller.phoneText,
                    validation: (value) {
                      if (value.isEmpty) {
                        return LocaleKeys.errorPhoneRequired.tr();
                      }
                      return null;
                    }),
                SizedBox(
                  height: Dimens.spacingMedium,
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(LocaleKeys.txtDefaultAddress.tr(), style: captionNormal1,),
                  value: controller.isDefault,
                  onChanged: (newValue) {
                    setState(() {
                      controller.isDefault = newValue;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
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
          keyboardType: inputType,
          focusNode: focusNode,
          onTap: onTap,
          controller: textEditingController,
          validator: validation,
          decoration: InputDecoration(hintText:hint, prefix:  Padding(
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
                            child: Text(
                              block.block_name,
                              style: bodyTextNormal1.copyWith(
                                  color: AppColors.neutralGray),
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
                            child: Text(
                              area.area_name,
                              style: bodyTextNormal1.copyWith(
                                  color: AppColors.neutralGray),
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
            text: LocaleKeys.addAddress.tr());
      });
}
