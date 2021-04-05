import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/models/ProductVariant.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class VariantPicker extends StatefulWidget {
  List<ProductVariant> variants;

  VariantPicker(this.variants);

  @override
  State<StatefulWidget> createState() => _VariantPickerState();
}

class _VariantPickerState extends State<VariantPicker> {
  var variantSelected;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: List.generate(
          widget.variants != null ? widget.variants.length : 0, (index) {
        if (widget.variants[index].display_as == "v_list")
          return dropdownList(widget.variants[index],
              widget.variants[index].product_variant_values);
        if (widget.variants[index].display_as == "h_list")
          return horizontalList(widget.variants[index],
              widget.variants[index].product_variant_values);
        return dropdownList(widget.variants[index],
            widget.variants[index].product_variant_values);
      }),
    );
  }

  Widget horizontalList(ProductVariant variant, List<ProductVariantValue> productVariantValues) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(capitalize(variant.name), style: heading5,),
        SizedBox(
          height: Dimens.spacingMedium,
        ),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: List.generate(productVariantValues.length, (index) {
              var value = productVariantValues[index];
                return Padding(padding: EdgeInsets.only(right :  8.0),
                child: value.value.startsWith('#') ? Container(
                  width: 48,
                  height: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(36)),
                      color: _getColorFromHex(value.value)
                  ),
                ): Container(
                  width: 48,
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(value.value),
                  )),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.neutralGray),

                  ),
                ),);
            }),
          ),
        ),
      ],
    );
  }
  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }
  Widget dropdownList(ProductVariant variant,
          List<ProductVariantValue> values) =>
      SizedBox(
        width: double.infinity,
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: AppColors.neutralGray)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
            child: DropdownButton<int>(
              elevation: 8,
              underline: SizedBox(),
              hint: Text(variant.name),
              value: variantSelected,
              isExpanded: true,
              icon: Icon(MaterialIcons.arrow_drop_down),
              items: values.map(
                  (ProductVariantValue value) {
                return DropdownMenuItem<int>(
                  value: value.id,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value.value,
                        style: heading6.copyWith(color: AppColors.neutralDark),
                      ),
                      Text(
                        "KD${value.price}",
                        style: captionNormal1.copyWith(
                            color: AppColors.neutralGray),
                      )
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  variantSelected = value;
                });
              },
            ),
          ),
        ),
      );
}

