import 'package:coupon_app/app/components/rating.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProductItem extends StatefulWidget {
  final Function onClickItem;

  ProductItem(this.onClickItem);

  @override
  State<StatefulWidget> createState() => ProductItemState();
}

class ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: InkWell(
          onTap: () {
            widget.onClickItem();
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: double.infinity,
                      height: 160,
                      decoration: const BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(Dimens.cornerRadius)),
                          color: AppColors.neutralLight),
                      child: Image.network(
                        "https://5.imimg.com/data5/PM/NW/JS/SELLER-42867842/discount-coupon-500x500.jpg",
                        fit: BoxFit.fill,
                      )),
                  SizedBox(
                    height: Dimens.spacingNormal,
                  ),
                  Text(
                    "Save 43% on 2 Kg Yummy Cakes of your Choice from Movenpick Free Zone",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: heading6.copyWith(color: AppColors.primary),
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  Row(
                    children: [
                      Icon(
                        MaterialCommunityIcons.timer,
                        color: AppColors.neutralDark,
                      ),
                      SizedBox(
                        width: Dimens.spacingNormal,
                      ),
                      Text(
                        "100h: 42m: 33s",
                        style: bodyTextMedium2,
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        "KD2",
                        style: bodyTextMedium1.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w900),
                      ),
                      Expanded(
                       child: SizedBox(),
                      ),
                      SizedBox(
                          height: 36,
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () {},
                            child: Text(
                              "Buy Now",
                              style: buttonText.copyWith(fontSize: 12),
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
