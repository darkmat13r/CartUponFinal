import 'package:coupon_app/app/components/price.dart';
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
import 'package:logger/logger.dart';

class CartItemView extends StatefulWidget {
  final CartItem item;
  final bool inStock;

  final Function onAdd;
  final Function onDelete;
  final Function onRemove;
  final Function onSelect;

  CartItemView(this.item,
      {this.onAdd, this.onDelete, this.onRemove, this.onSelect, this.inStock});

  @override
  State<StatefulWidget> createState() => CartItemViewState();
}

class CartItemViewState extends State<CartItemView> {
  String selectedCount;

  @override
  Widget build(BuildContext context) {
    var isMaxQtyContains =  (widget.item.product_id?.maxQty ?? 0) > 0;
    var maxQty =  (widget.item.product_id?.maxQty ?? 0);
    var stock = widget.item.variant_value_id != null
        ? widget.item.variant_value_id.stock
        : widget.item.product_id.stock;
    var isMaxQty =  (widget.item.qty == maxQty || maxQty == 0);
    Logger().e("Current qty ${widget.item.qty }");
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          Dimens.spacingNormal, Dimens.spacingNormal, Dimens.spacingNormal, 0),
      child: InkWell(
        onTap: widget.onSelect != null
            ? () {
                widget.onSelect(widget.item);
              }
            : null,
        child: Card(
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimens.spacingNormal),
                  child: widget.item != null  && widget.item.variant_value_id == null ? ProductThumbnail(
                      widget.item != null && widget.item.product_id != null
                          ? widget.item.product_id.thumb_img
                          : "") : ProductThumbnail(
                      widget.item != null
                          ? widget.item.variant_value_id.image
                          : ""),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Dimens.spacingNormal,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: Dimens.spacingMedium),
                        child: Text(
                          widget.item != null &&
                                  widget.item.product_id != null &&
                                  widget.item.product_id.product_detail != null
                              ? widget.item.product_id.product_detail.name ??
                                  "-"
                              : "-",
                          maxLines: 1,
                          style:
                              heading6.copyWith(color: AppColors.neutralDark),
                        ),
                      ),
                      Visibility(
                        visible: widget.item != null && widget.item.variant_value_id != null,
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: Dimens.spacingMedium),
                          child: Text(
                            widget.item != null && widget.item.variant_value_id != null ? widget.item.variant_value_id.value : "",
                            maxLines: 1,
                            style:
                            captionNormal1.copyWith(color: AppColors.neutralGray),
                          ),
                        ),
                      ),

                      Padding(
                        padding:
                            const EdgeInsets.only(left: Dimens.spacingMedium),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: widget.item != null && widget.item.product_id != null && widget.item.product_id.maxQty > 0,
                                    child: Column(
                                      children: [
                                        Text(LocaleKeys.maxQty.tr(args : [widget.item.product_id.maxQty.toString()])),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: !widget.inStock,
                                    child: Text(
                                      LocaleKeys.outOfStock.tr(),
                                      style: captionNormal2.copyWith(
                                          color: AppColors.error),
                                    ),
                                  ),
                                  Visibility(
                                      visible: widget.inStock,
                                      child: Price(product : widget.item.product_id,variantValue:widget.item.variant_value_id,))
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top : 8.0),
                              child: QuantityButton(
                                widget.item.qty,
                                inStock: widget.inStock,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                max: maxQty < stock ? maxQty : stock,
                                onAdd: (qty) {
                                  setState(() {
                                    if (widget.onAdd != null) {
                                      widget.onAdd(widget.item, qty);
                                    }
                                  });
                                },
                                onDelete: () {
                                 setState(() {
                                   if (widget.onDelete != null) {
                                     widget.onDelete(widget.item);
                                   }
                                 });
                                },
                                onRemove: (qty) {
                                  setState(() {
                                    if (widget.onRemove != null) {
                                      widget.onRemove(widget.item, qty);
                                    }
                                  });
                                },
                              ),
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
      ),
    );
  }
}

