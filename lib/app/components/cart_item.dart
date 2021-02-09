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
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all( Radius.circular(Dimens.cornerRadius), ),
                            border:  Border.all(color: AppColors.neutralLight, width: Dimens.borderWidth)
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimens.spacingMicro, horizontal: Dimens.spacingNormal),
                                child: Icon(MaterialCommunityIcons.minus, color: AppColors.neutralGray, size: 16,),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.neutralLight
                                ),
                                child:
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: Dimens.spacingMicro, horizontal: Dimens.spacingMedium),
                                  child: Text("1",style: bodyTextNormal1.copyWith(color: AppColors.neutralGray),),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimens.spacingMicro, horizontal: Dimens.spacingNormal),
                                child: Icon(MaterialCommunityIcons.plus, color: AppColors.neutralGray, size: 16,),
                              )
                            ],
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
