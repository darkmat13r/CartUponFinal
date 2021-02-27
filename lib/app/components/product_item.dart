import 'package:coupon_app/app/components/buy_now_button.dart';
import 'package:coupon_app/app/components/rating.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProductItem extends StatefulWidget {
  final Function onClickItem;
  final ProductEntity product;

  ProductItem({
    @required this.product,
    @required this.onClickItem,
  });

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
            if (widget.product != null)
              AppRouter().productDetails(context, widget.product);
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
                      child: widget.product != null &&
                              widget.product.images[0].startsWith("http")
                          ? Image.network(
                              widget.product != null
                                  ? widget.product.images[0]
                                  : "",
                              fit: BoxFit.fill,
                            )
                          : Image.asset(widget.product != null
                              ? widget.product.images[0]
                              : "",  fit: BoxFit.fill,)),
                  SizedBox(
                    height: Dimens.spacingNormal,
                  ),
                  Text(
                    widget.product != null ? widget.product.name : "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: heading6.copyWith(color: AppColors.primary),
                  ),
                  SizedBox(
                    height: Dimens.spacingNormal,
                  ),


                  Row(
                    children: [
                      Image.asset(
                        Resources.timerIcon,
                        width: 24,
                        height: 24,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "KD${widget.product != null ? widget.product.price : ""}",
                          style: bodyTextMedium1.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      BuyNowButton(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
