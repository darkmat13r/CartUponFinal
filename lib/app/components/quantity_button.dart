import 'package:coupon_app/app/components/rounded_box.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:logger/logger.dart';

class QuantityButton extends StatefulWidget {
  final int initialQuantity;
  final bool inStock;
  final int max;
  final CrossAxisAlignment crossAxisAlignment;
  final Function onAdd;
  final Function onRemove;
  final Function onDelete;

  QuantityButton(this.initialQuantity,
      {this.onAdd,
      this.onDelete,
      this.onRemove,
      this.max,
      this.crossAxisAlignment,
      this.inStock}){
    Logger().e("Max ${inStock}");
  }

  @override
  State<StatefulWidget> createState() => _QuantityButtonState(initialQuantity);
}

class _QuantityButtonState extends State<QuantityButton> {
  int currentQty = 1;

  _QuantityButtonState(this.currentQty) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: widget.inStock && currentQty != widget.max ? _normalQuantity() : _outOfStockQuantity(),
    );
  }

  Row _outOfStockQuantity() {
    return Row(
      crossAxisAlignment:
          widget.crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              LocaleKeys.fmtQty.tr(args: [currentQty.toString()]),
              style: bodyTextNormal1.copyWith(color: AppColors.neutralGray),
            )),
          ),
        ),
        InkWell(
            onTap: () {
              setState(() {
                if (currentQty > 1) {
                  currentQty--;
                  if (widget.onRemove != null) {
                    widget.onRemove(currentQty);
                  }
                } else if (currentQty == 1) {
                  if (widget.onDelete != null) {
                    widget.onDelete();
                  }
                }
              });
            },
            child: RoundedBox(
                color: currentQty == 1
                    ? AppColors.error
                    : AppColors.neutralLightGray,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    currentQty == 1
                        ? MaterialCommunityIcons.trash_can
                        : MaterialCommunityIcons.minus,
                    color: currentQty == 1
                        ? AppColors.neutralLight
                        : AppColors.neutralDark,
                    size: 18,
                  ),
                ))),
        // InkWell(
        //     onTap: () {
        //       setState(() {
        //         if (widget.max == null ||
        //             (widget.max != null && widget.max > currentQty)) {
        //           currentQty++;
        //           if (widget.onAdd != null) {
        //             widget.onAdd(currentQty);
        //           }
        //         }
        //       });
        //     },
        //     child: RoundedBox(
        //         color: AppColors.neutralLightGray,
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Icon(MaterialCommunityIcons.plus, color: AppColors.neutralDark,  size: 18,),
        //         ))),
      ],
    );
  }

  Row _normalQuantity() {
    return Row(
      crossAxisAlignment:
          widget.crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              setState(() {
                if (currentQty > 1) {
                  currentQty--;
                  if (widget.onRemove != null) {
                    widget.onRemove(currentQty);
                  }
                } else if (currentQty == 1) {
                  if (widget.onDelete != null) {
                    widget.onDelete();
                  }
                }
              });
            },
            child: RoundedBox(
                color: currentQty == 1
                    ? AppColors.error
                    : AppColors.neutralLightGray,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    currentQty == 1
                        ? MaterialCommunityIcons.trash_can
                        : MaterialCommunityIcons.minus,
                    color: currentQty == 1
                        ? AppColors.neutralLight
                        : AppColors.neutralDark,
                    size: 18,
                  ),
                ))),
        SizedBox(
          width: 36,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              currentQty.toString(),
              style: bodyTextNormal1.copyWith(color: AppColors.neutralGray),
            )),
          ),
        ),
        InkWell(
            onTap: () {
              setState(() {
                if (widget.max == null ||
                    (widget.max != null && widget.max > currentQty)) {
                  currentQty++;
                  if (widget.onAdd != null) {
                    widget.onAdd(currentQty);
                  }
                }
              });
            },
            child: RoundedBox(
                color: AppColors.neutralLightGray,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    MaterialCommunityIcons.plus,
                    color: AppColors.neutralDark,
                    size: 18,
                  ),
                ))),
      ],
    );
  }
}
