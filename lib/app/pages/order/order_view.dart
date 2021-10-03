import 'package:coupon_app/app/components/app_image.dart';
import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/dotted_view.dart';
import 'package:coupon_app/app/components/outlined_box.dart';
import 'package:coupon_app/app/components/product_thumbnail.dart';
import 'package:coupon_app/app/components/review.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/order/order_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/date_helper.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:coupon_app/data/repositories/data_order_repository.dart';
import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:coupon_app/domain/entities/models/OrderDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderPage extends View {
  final OrderDetail order;

  OrderPage({this.order});

  @override
  State<StatefulWidget> createState() => OrderPageState(order: order);
}

class OrderPageState extends ViewState<OrderPage, OrderController> {
  OrderPageState({OrderDetail order})
      : super(OrderController(
            DataAuthenticationRepository(), DataOrderRepository(),
            orderDetail: order));

  @override
  Widget get view => Scaffold(
        appBar: customAppBar(
            title: Text(
          LocaleKeys.orderDetails.tr(),
          style: heading5.copyWith(color: AppColors.primary),
        )),
        key: globalKey,
        body: _stateViewBody,
      );

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext context, OrderController controller) {
        return ListView(
          children: [
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            _qrCode,
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
              child: Text(
                LocaleKeys.product.tr(),
                style: heading5.copyWith(color: AppColors.neutralDark),
              ),
            ),
            _products(controller),
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
              child: Text(
                LocaleKeys.orderDetails.tr(),
                style: heading5.copyWith(color: AppColors.neutralDark),
              ),
            ),
            _orderDetails(controller),
            SizedBox(
              height: Dimens.spacingMedium,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
              child: Text(
                LocaleKeys.shippingDetails.tr(),
                style: heading5.copyWith(color: AppColors.neutralDark),
              ),
            ),
            _shippingDetails(controller),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
              child: Text(
                LocaleKeys.paymentDetails.tr(),
                style: heading5.copyWith(color: AppColors.neutralDark),
              ),
            ),
            _paymentDetails(controller),
            controller.rating != null && controller.rating.rating != null
                ? reviewItem(controller)
                : controller.canPostReview()
                    ? _addReview
                    : SizedBox(),
            controller.canCancelOrder()
                ? Padding(
                    padding: const EdgeInsets.all(Dimens.spacingMedium),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          controller.cancelOrder();
                        },
                        child: Text(
                          LocaleKeys.cancelOrder.tr(),
                          style: buttonText,
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        );
      });

  get _qrCode => ControlledWidgetBuilder(
          builder: (BuildContext context, OrderController controller) {
        return controller.orderDetail != null &&
                controller.orderDetail.product_id != null &&
                controller.orderDetail.product_id.category_type == false
            ? Column(
                children: [
                  InkWell(
                    onTap: () {
                      controller.showImage(controller.orderDetail.qr_image);
                    },
                    child: SizedBox(
                        width: 220,
                        height: 220,
                        child: AppImage(controller.orderDetail.qr_image)),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.couponCode.tr(),
                            style:
                                heading6.copyWith(color: AppColors.neutralGray),
                          ),
                          Text(
                            controller.orderDetail.qr_code,
                            style: heading5,
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.content_copy_rounded),
                        color: AppColors.accent,
                        onPressed: () {
                          final data = ClipboardData(
                              text: controller.orderDetail.qr_code);
                          Clipboard.setData(data).then((value) =>
                              showGenericSnackbar(
                                  context, LocaleKeys.couponCodeMessage.tr()));
                        },
                      ),
                    ],
                  ),
                ],
              )
            : SizedBox();
      });

  reviewItem(OrderController controller) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.spacingNormal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
            child: Text(
              LocaleKeys.yourReview.tr(),
              style: heading5.copyWith(color: AppColors.neutralDark),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.spacingMedium),
              child: ReviewItem(
                controller.rating,
                token: controller.currentUser,
              ),
            ),
          ),
        ],
      ),
    );
  }

  get _addReview => ControlledWidgetBuilder(
          builder: (BuildContext context, OrderController controller) {
        return controller.currentUser != null
            ? SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.spacingMedium),
                  child: OutlinedButton(
                    onPressed: () {
                      controller.addReview();
                    },
                    child: Text(
                      LocaleKeys.writeReview.tr(),
                      style: buttonText.copyWith(color: AppColors.accent),
                    ),
                  ),
                ),
              )
            : SizedBox();
      });

  get _stateViewBody => ControlledWidgetBuilder(
          builder: (BuildContext context, OrderController controller) {
        return StateView(
            controller.isLoading ? EmptyState.LOADING : EmptyState.CONTENT,
            _body);
      });

  Widget _paymentDetails(OrderController controller) {
    return Visibility(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacingNormal),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: Column(
              children: [
                _detailItem(
                    LocaleKeys.items
                        .tr(args: [controller.orderDetail.qty.toString()]),
                    Utility.currencyFormat(controller.orderDetail.price)),
                DotWidget(
                  color: AppColors.neutralGray,
                ),
                _detailItem(
                    LocaleKeys.shipping.tr(),
                    Utility.currencyFormat(
                        controller.orderDetail.order.shipping_total)),
                _detailItem(LocaleKeys.totalPrice.tr(),
                    Utility.currencyFormat(controller.orderDetail.order.total)),
              ],
            ),
          ),
        ),
      ),
      visible: controller.orderDetail != null,
    );
  }

  Widget _orderDetails(OrderController controller) {
    return controller.orderDetail != null
        ? Padding(
            padding: const EdgeInsets.all(Dimens.spacingNormal),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacingMedium),
                child: Column(
                  children: [
                    _detailItem(
                        LocaleKeys.orderDetailId.tr(),
                        controller.orderDetail.id != null
                            ? "${controller.orderDetail.id}"
                            : ""),
                    _detailItem(
                        LocaleKeys.orderNumber.tr(),
                        controller.orderDetail.order.order_no != null
                            ? "${controller.orderDetail.order.order_no}"
                            : ""),
                  ],
                ),
              ),
            ),
          )
        : SizedBox();
  }

  Widget _shippingDetails(OrderController controller) {
    return controller.orderDetail != null
        ? Padding(
            padding: const EdgeInsets.all(Dimens.spacingNormal),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacingMedium),
                child: Column(
                  children: [
                    _detailItem(
                        LocaleKeys.fullName.tr(),
                        controller.orderDetail.order.shipping_address != null
                            ? "${controller.orderDetail.order.shipping_address.first_name} ${controller.orderDetail.order.shipping_address.last_name}"
                            : ""),
                    _detailItem(
                        LocaleKeys.mobileNumber.tr(),
                        controller.orderDetail.order.shipping_address != null
                            ? "${controller.orderDetail.order.shipping_address.phone_no}"
                            : ""),
                    _detailItem(
                        LocaleKeys.orderShippingDate.tr(),
                        DateHelper.formatServerDate(
                            controller.orderDetail.order.created_at)),
                    _detailItem(
                        LocaleKeys.address.tr(),
                        controller.orderDetail.order.shipping_address != null
                            ? Utility.addressFormatter(
                                controller.orderDetail.order.shipping_address)
                            : ""),
                    _detailItem(LocaleKeys.orderStatus.tr(),
                        LocaleKeys.orderStatusShipping.tr()),
                  ],
                ),
              ),
            ),
          )
        : SizedBox();
  }

  Widget _detailItem(name, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Text(
                name,
                style: bodyTextNormal2.copyWith(color: AppColors.neutralGray),
              )),
          SizedBox(
            width: Dimens.spacingNormal,
          ),
          Expanded(
              flex: 1,
              child: Text(value,
                  textAlign: TextAlign.end,
                  style:
                      bodyTextNormal2.copyWith(color: AppColors.neutralDark)))
        ],
      ),
    );
  }

  Widget _products(OrderController controller) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return _productDetail(controller.orderDetail, controller);
        });
  }

  _productDetail(OrderDetail orderDetail, OrderController controller) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Dimens.spacingNormal,
          left: Dimens.spacingNormal,
          right: Dimens.spacingNormal),
      child: InkWell(
        onTap: () {
          if (orderDetail.product_id != null &&
              orderDetail.product_id.product_detail != null)
            controller.showProductDetails(
                orderDetail.product_id.product_detail.id.toString());
        },
        child: Card(
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimens.spacingNormal),
                  child: orderDetail.variant_value_id == null
                      ? ProductThumbnail(
                          orderDetail != null && orderDetail.product_id != null
                              ? orderDetail.product_id.thumb_img
                              : "")
                      : ProductThumbnail(orderDetail != null
                          ? orderDetail.variant_value_id.image
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
                          orderDetail != null &&
                                  orderDetail.product_id != null &&
                                  orderDetail.product_id.product_detail != null
                              ? orderDetail.product_id.product_detail.name ??
                                  "-"
                              : "-",
                          maxLines: 1,
                          style:
                              heading6.copyWith(color: AppColors.neutralDark),
                        ),
                      ),

                      Visibility(
                        visible:  orderDetail != null && orderDetail.variant_value_id != null,
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: Dimens.spacingMedium),
                          child: Text(
                            orderDetail != null && orderDetail.variant_value_id != null ? orderDetail.variant_value_id.value : "",
                            maxLines: 1,
                            style:
                            captionNormal1.copyWith(color: AppColors.neutralGray),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.spacingSmall,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: Dimens.spacingMedium),
                        child: Text(Utility.capitalize(controller
                            .orderDetail.detail_status
                            .toLowerCase())),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: Dimens.spacingMedium),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                LocaleKeys.fmtQty
                                    .tr(args: [orderDetail.qty.toString()]),
                                style: captionNormal1.copyWith(
                                    color: AppColors.neutralGray),
                              ),
                            ),
                            Text(
                              Utility.getOrderItemPrice(orderDetail.product_id,
                                  orderDetail.variant_value_id),
                              style:
                                  heading6.copyWith(color: AppColors.primary),
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
