import 'package:coupon_app/app/components/product_thumbnail.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CartItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CartItemState();
}

class CartItemState extends State<CartItem> {
  String count = "1";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          Dimens.spacingMedium, Dimens.spacingNormal, Dimens.spacingMedium, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingMedium),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductThumbnail(),
              SizedBox(
                width: Dimens.spacingMedium,
              ),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Nike Air Zoom Pegasus 36 Miami",
                      style:
                      heading6.copyWith(color: AppColors.neutralDark),
                    ),
                    SizedBox(
                      height: Dimens.spacingNormal,
                    ),
                    Row(
                      children: [
                        Expanded(child: Text("\$299,43", style: heading6.copyWith(color: AppColors.primary),)),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              border:  Border.all(color: AppColors.neutralGray, width: Dimens.borderWidth)
                            ),
                            child: new DropdownButton<String>(
                                underline: SizedBox(),
                              style: bodyTextNormal1.copyWith(color: AppColors.neutralDark),
                              items: <String>['1', '2', '3', '4'].map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Expanded(child: new Text(value, style: bodyTextNormal1.copyWith(color: AppColors.neutralDark),)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  count = value;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
