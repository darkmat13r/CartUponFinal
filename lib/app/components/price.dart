import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/entities/models/ProductVariantValue.dart';
import 'package:flutter/material.dart';

class Price extends StatelessWidget {
  const Price({
    Key key,
    @required this.product,
    @required this.variantValue,
  }) : super(key: key);

  final Product product;
  final ProductVariantValue variantValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Utility.checkOfferPrice(
            this.product,
            product
                .isInOffer(), variantValue: variantValue)
            ? Text(
          Utility.getOrderItemPrice(
              product, variantValue),
          style:
          captionNormal1.copyWith(
              color: AppColors
                  .neutralGray,
              decoration:
              TextDecoration
                  .lineThrough),
        )
            : SizedBox(),
        Text(
          Utility.currencyFormat(product!=
              null
              ? product.getOfferPriceByVariant(variantValue)
              : 0),
          style: bodyTextNormal1.copyWith(
              color: AppColors.primary),
        ),
      ],
    );
  }
}


class VariantPrice extends StatelessWidget {
  const VariantPrice({
    Key key,
    @required this.product,
    @required this.variantValue,
  }) : super(key: key);

  final Product product;
  final ProductVariantValue variantValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Utility.checkOfferPrice(
            this.product,
            product
                .isInOffer(), variantValue: variantValue)
            ? Text(
          Utility.getOrderItemPrice(
              product, variantValue),
          style:
          captionNormal1.copyWith(
              color: AppColors
                  .neutralGray,
              decoration:
              TextDecoration
                  .lineThrough),
        )
            : SizedBox(),
        SizedBox(
          width: Dimens.spacingSmall,
        ),
        Text(
          Utility.currencyFormat(product!=
              null
              ? product.getOfferPriceByVariant(variantValue)
              : 0),
          style: bodyTextNormal1.copyWith(
              color: AppColors.primary),
        ),
      ],
    );
  }
}
