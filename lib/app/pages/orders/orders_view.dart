import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/dotted_view.dart';
import 'package:coupon_app/app/components/outlined_box.dart';
import 'package:coupon_app/app/components/product_thumbnail.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/orders/orders_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/data/repositories/data_order_repository.dart';
import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:coupon_app/domain/entities/models/OrderDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_icons/flutter_icons.dart';

class OrdersPage extends View {
  final String status;

  OrdersPage(String status) : this.status = status == null ? "pending" : status;

  @override
  State<StatefulWidget> createState() => OrdersPageState(status);
}

class OrdersPageState extends ViewState<OrdersPage, OrdersController> {
  OrdersPageState(String status)
      : super(OrdersController(status, DataOrderRepository()));

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: _body,
      );

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext context, OrdersController controller) {
        return StateView(
            controller.isLoading
                ? EmptyState.LOADING
                : controller.orders != null && controller.orders.length > 0
                    ? EmptyState.CONTENT
                    : EmptyState.EMPTY,
            _orders(controller));
      });

  Widget _orders(OrdersController controller) {
    return ListView.builder(
        itemCount: controller.orders != null ? controller.orders.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return _orderDetails(controller.orders[index], controller);
        });
  }

  _orderDetails(OrderDetail order, OrdersController controller) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Dimens.spacingNormal,
          left: Dimens.spacingNormal,
          right: Dimens.spacingNormal),
      child: InkWell(
        onTap: () {
          controller.orderDetails(order);
        },
        child: Card(
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimens.spacingNormal),
                  child: order.variant_value_id != null
                      ? ProductThumbnail(
                          order != null && order.product_id != null
                              ? order.product_id.thumb_img
                              : "")
                      : ProductThumbnail(
                          order != null ? order.variant_value_id.image : ""),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Dimens.spacingMedium,
                      ),
                      order.order != null
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: Dimens.spacingMedium),
                              child: Text(
                                "${LocaleKeys.orderDetailId.tr()} : ${order.id}",
                                style: heading5.copyWith(
                                    color: AppColors.neutralDark),
                              ),
                            )
                          : SizedBox(),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: Dimens.spacingMedium),
                        child: Text(
                          order != null &&
                                  order.order != null &&
                                  order.order.order_no != null
                              ? "${LocaleKeys.orderNumber.tr()}. : ${order.order.order_no}"
                              : "-",
                          style: bodyTextNormal2.copyWith(
                              color: AppColors.neutralGray),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: Dimens.spacingMedium),
                        child: Text(
                          order != null &&
                                  order.product_id != null &&
                                  order.product_id.product_detail != null
                              ? order.product_id.product_detail.name ?? "-"
                              : "-",
                          maxLines: 1,
                          style:
                              heading6.copyWith(color: AppColors.neutralDark),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.spacingNormal,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: Dimens.spacingMedium),
                        child: order != null && order.order != null
                            ? Row(
                                children: [
                                  Text(
                                      Utility.currencyFormat(order.order.total),
                                      style: bodyTextNormal1.copyWith(
                                          color: AppColors.primary)),
                                  Expanded(
                                    child: SizedBox(),
                                  ),
                                  Text(Utility.capitalize(
                                      order.detail_status.toLowerCase())),
                                ],
                              )
                            : SizedBox(),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: Dimens.spacingMedium),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            order.order != null
                                ? Text(
                                    LocaleKeys.orderAt.tr(namedArgs: {
                                      "location": "",
                                      "date": DateHelper.formatServerDate(
                                          order.order.created_at)
                                    }),
                                    style: bodyTextNormal2.copyWith(
                                        color: AppColors.neutralGray),
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: Dimens.spacingNormal,
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
                Icon(
                  MaterialCommunityIcons.chevron_right,
                  color: AppColors.neutralGray,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _orderItem(OrderDetail order) => ControlledWidgetBuilder(
        builder: (BuildContext context, OrdersController controller) {
          return InkWell(
            onTap: () {
              controller.orderDetails(order);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: Dimens.spacingSmall,
                  left: Dimens.spacingNormal,
                  right: Dimens.spacingNormal),
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(Dimens.spacingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    order.order != null
                        ? Text(
                            "#${order.id}",
                            style:
                                heading5.copyWith(color: AppColors.neutralDark),
                          )
                        : SizedBox(),
                    order.order != null
                        ? Text(
                            order.order.shipping_address != null
                                ? Utility.addressFormatter(
                                    order.order.shipping_address)
                                : "",
                            style: captionNormal1.copyWith(
                                color: AppColors.neutralGray),
                          )
                        : SizedBox(),
                    order.order != null
                        ? Text(
                            LocaleKeys.orderAt.tr(namedArgs: {
                              "location": "",
                              "date": DateHelper.formatServerDate(
                                  order.order.created_at)
                            }),
                            style: bodyTextNormal2.copyWith(
                                color: AppColors.neutralGray),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: Dimens.spacingSmall,
                    ),
                    DotWidget(
                      color: AppColors.neutralLightGray,
                      width: 8,
                      height: Dimens.borderWidth,
                    ),
                    SizedBox(
                      height: Dimens.spacingSmall,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          LocaleKeys.orderStatus.tr(),
                          style: bodyTextNormal2.copyWith(
                              color: AppColors.neutralGray),
                        )),
                        Text(Utility.capitalize(order.detail_status),
                            style: bodyTextNormal2.copyWith(
                                color: AppColors.neutralDark))
                      ],
                    ),
                    SizedBox(
                      height: Dimens.spacingSmall,
                    ),
                    /* Row(
                      children: [
                        Expanded(child: Text(LocaleKeys.orderItems.tr(),
                          style: bodyTextNormal2.copyWith(
                              color: AppColors.neutralGray),)),
                        Text(LocaleKeys.fmtItemsPurchased.tr(args: [(order != null ? order.order_details.length  : 0).toString()]),
                            style: bodyTextNormal2.copyWith(color: AppColors
                                .neutralDark))
                      ],
                    ),*/
                    SizedBox(
                      height: Dimens.spacingSmall,
                    ),
                    order.order != null
                        ? Row(
                            children: [
                              Expanded(
                                  child: Text(
                                LocaleKeys.price.tr(),
                                style: bodyTextNormal2.copyWith(
                                    color: AppColors.neutralGray),
                              )),
                              Text(Utility.currencyFormat(order.order.total),
                                  style: bodyTextNormal1.copyWith(
                                      color: AppColors.primary))
                            ],
                          )
                        : SizedBox()
                  ],
                ),
              )),
            ),
          );
        },
      );
}
