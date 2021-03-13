import 'package:coupon_app/app/components/product_thumbnail.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/mapper/cart_item_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CartItem extends StatefulWidget {
  CartItemMapper cartItemMapper;

  CartItem(this.cartItemMapper);

  @override
  State<StatefulWidget> createState() => CartItemState();
}

class CartItemState extends State<CartItem> {
  String selectedCount;

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
              ProductThumbnail(widget.cartItemMapper != null ?  widget.cartItemMapper.image : ""),
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
                     widget.cartItemMapper != null ? widget.cartItemMapper.name : "-",
                      style: heading6.copyWith(color: AppColors.neutralDark),
                    ),
                    SizedBox(
                      height: Dimens.spacingNormal,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.neutralGray,
                                    width: Dimens.borderWidth)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.spacingMedium),
                              child: new DropdownButton<String>(
                                underline: SizedBox(),
                                isExpanded: true,
                                hint: Text("1"),
                                style: bodyTextNormal1.copyWith(
                                    color: AppColors.neutralDark),
                                items: <String>['1', '2', '3', '4']
                                    .map((String value) {
                                  return DropdownMenuItem(
                                    value: widget.cartItemMapper != null ? widget.cartItemMapper.quantity.toString()  :  0.toString() ,
                                    child: new Text(
                                      value,
                                      style: bodyTextNormal1.copyWith(
                                      color: AppColors.neutralDark),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCount = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                          ),
                        ),
                        Text(
                          "KD${  widget.cartItemMapper != null ? widget.cartItemMapper.price : "-"}",
                          style: heading6.copyWith(color: AppColors.primary),
                        ),
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
