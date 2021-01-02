import 'package:coupon_app/app/components/rating.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget{

  final Function onClickItem;


  ProductItem(this.onClickItem);

  @override
  State<StatefulWidget> createState() => ProductItemState();

}


class ProductItemState extends State<ProductItem>{


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: InkWell(
          onTap: (){
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
                      height: 120,
                      decoration: const BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(Dimens.cornerRadius)),
                          color: AppColors.neutralLight),
                      child: Image(
                        width: double.infinity,
                        image: AssetImage(Resources.shoe),
                      )),
                  SizedBox(
                    height: Dimens.spacingNormal,
                  ),
                  Text(
                    "Nike Air MAx 270 React ENG",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: heading6.copyWith(color: AppColors.neutralDark),
                  ),
                  Rating(),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  Text(
                    "\$299,43",
                    style: bodyTextNormal1.copyWith(color: AppColors.primary),
                  ),
                  Row(
                    children: [
                      Text(
                        "\$534,33",
                        style: bodyTextNormal2.copyWith(
                            color: AppColors.neutralGray),
                      ),
                      SizedBox(
                        width: Dimens.spacingSmall,
                      ),
                      Text(
                        "24% Off",
                        style: bodyTextNormal1.copyWith(color: AppColors.error),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

}