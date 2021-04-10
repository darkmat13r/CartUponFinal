import 'package:coupon_app/app/components/product_thumbnail.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/mapper/cart_item_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CartItemView extends StatefulWidget {
  CartItem cartItemMapper;

  CartItemView(this.cartItemMapper);

  @override
  State<StatefulWidget> createState() => CartItemViewState();
}

class CartItemViewState extends State<CartItemView> {
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
              ProductThumbnail(widget.cartItemMapper != null && widget.cartItemMapper.product_id != null ?  widget.cartItemMapper.product_id.thumb_img : ""),
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
                     widget.cartItemMapper != null  && widget.cartItemMapper.product_id != null
                         ? widget.cartItemMapper.product_id.title ?? "-" : "-",
                      style: heading6.copyWith(color: AppColors.neutralDark),
                    ),
                    SizedBox(
                      height: Dimens.spacingNormal,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(widget.cartItemMapper != null
                              && widget.cartItemMapper.product_id != null
                              ? LocaleKeys.fmtQty.tr(args: [widget.cartItemMapper.qty.toString()]) : "0", style: bodyTextNormal1,),
                        ),
                        Expanded(
                          child: SizedBox(
                          ),
                        ),
                        Text(
                          Utility.getCartItemPrice(widget.cartItemMapper),
                          style: heading6.copyWith(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: IconButton(onPressed: (){}, icon: Icon(MaterialCommunityIcons.trash_can), color: AppColors.error,),
              )
            ],
          ),
        ),
      ),
    );
  }

}
