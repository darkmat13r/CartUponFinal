import 'package:coupon_app/app/components/product_thumbnail.dart';
import 'package:coupon_app/app/components/quantity_button.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/mapper/cart_item_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CartItemView extends StatefulWidget {
  final CartItem item;

  final Function onAdd;
  final Function onDelete;
  final Function onRemove;

  CartItemView(this.item, {this.onAdd, this.onDelete, this.onRemove});

  @override
  State<StatefulWidget> createState() => CartItemViewState();
}

class CartItemViewState extends State<CartItemView> {
  String selectedCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          Dimens.spacingNormal, Dimens.spacingNormal, Dimens.spacingNormal, 0),
      child: Card(
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(Dimens.spacingNormal),
                child: ProductThumbnail(widget.item != null &&
                        widget.item.product_id != null
                    ? widget.item.product_id.thumb_img
                    : ""),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimens.spacingMedium,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: Dimens.spacingMedium),
                      child: Text(
                        widget.item != null &&
                                widget.item.product_id != null && widget.item.product_id.product_detail != null
                            ? widget.item.product_id.product_detail.name ?? "-"
                            : "-",
                        maxLines: 1,
                        style: heading6.copyWith(color: AppColors.neutralDark),
                      ),
                    ),
                    SizedBox(
                      height: Dimens.spacingNormal,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: Dimens.spacingMedium),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              Utility.getCartItemPrice(widget.item),
                              style: heading6.copyWith(color: AppColors.primary),
                            ),
                          ),
                          QuantityButton(
                            widget.item.qty,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            max: widget.item.variant_value_id != null
                                ? widget.item.variant_value_id.stock
                                : widget.item.product_id.stock,
                            onAdd: (qty){
                              if(widget.onAdd != null){
                                widget.onAdd(widget.item, qty);
                              }
                            },
                            onDelete: (){
                              if(widget.onDelete != null){
                                widget.onDelete(widget.item);
                              }
                            },
                            onRemove: (qty){
                              if(widget.onRemove != null){
                                widget.onRemove(widget.item, qty);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: Dimens.spacingMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
