import 'package:coupon_app/app/components/app_image.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/whishlist/whishlist_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:coupon_app/data/repositories/data_whishlist_repository.dart';
import 'package:coupon_app/domain/repositories/whishlist_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class WhishlistPage extends View {
  @override
  State<StatefulWidget> createState() => _WhishlistPageState();
}

class _WhishlistPageState
    extends ViewState<WhishlistPage, WhishlistController> {
  _WhishlistPageState()
      : super(WhishlistController(
            DataWhishlistRepository(), DataAuthenticationRepository()));

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: _body,
      );

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext context, WhishlistController controller) {
        return StateView(
            controller.isLoading
                ? EmptyState.LOADING
                : (controller.whishListItems == null ||
                        controller.whishListItems.length == 0)
                    ? EmptyState.EMPTY
                    : EmptyState.CONTENT,
            _content);
      });

  get _content =>
      ControlledWidgetBuilder(builder: (ctx, WhishlistController controller) {
        return GridView.builder(
          itemCount: controller.whishListItems != null
              ? controller.whishListItems.length
              : 0,
          itemBuilder: (ctx, int index) {
            var item = controller.whishListItems[index];
            return InkWell(
              onTap:  item.product_id != null && item.product_id.product_detail != null ?(){
                  controller.showProductDetails(item.product_id.product_detail);
              }:null,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: Dimens.thumbImageHeight,
                        child: AppImage(item.product_id != null
                            ? item.product_id.thumb_img
                            : ""),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.spacingMedium,
                          vertical: Dimens.spacingNormal),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.product_id != null &&
                                    item.product_id.product_detail != null
                                ? item.product_id.product_detail.name
                                : "",
                            maxLines: 1,
                            style: bodyTextNormal1.copyWith(
                                color: AppColors.primary),
                          ),
                          Text(
                            item.product_id != null &&
                                    item.product_id.product_detail != null
                                ? item.product_id.product_detail.short_description
                                : "",
                            maxLines: 1,
                            style: captionNormal1.copyWith(
                                color: AppColors.neutralGray),
                          ),
                          SizedBox(height: Dimens.spacingNormal),
                          Row(
                            children: [
                              Utility.checkOfferPrice(
                                  item.product_id != null ? item.product_id : null, item.product_id.isInOffer())
                                  ? Text(
                                Utility.currencyFormat(
                                    item.product_id != null
                                        ? item.product_id.price
                                        : "0"),
                                style: captionNormal2.copyWith(
                                    color: AppColors.neutralGray,
                                    decoration:
                                    TextDecoration.lineThrough),
                              )
                                  : SizedBox(),

                              Text(
                                Utility.currencyFormat(item.product_id != null
                                    ? item.product_id.isInOffer() && item.product_id.offer_price != "0"
                                    ? item.product_id.offer_price
                                    : item.product_id.sale_price
                                    : 0),
                                style: bodyTextNormal1.copyWith(
                                    color: AppColors.primary),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SizedBox(
                        height: 36,
                        width : double.infinity,
                        child: TextButton(
                            onPressed: () {
                              controller.delete(item);
                            },
                            child: Text(
                              LocaleKeys.remove.tr(),
                              style: bodyTextNormal1.copyWith(
                                  color: AppColors.neutralLightGray),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.7),
        );
      });
}
