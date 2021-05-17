import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/dotted_view.dart';
import 'package:coupon_app/app/components/outlined_box.dart';
import 'package:coupon_app/app/pages/orders/orders_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_icons/flutter_icons.dart';
class OrdersPage extends View{
  @override
  State<StatefulWidget> createState() => OrdersPageState();

}


class OrdersPageState extends ViewState<OrdersPage, OrdersController>{
  OrdersPageState() : super(OrdersController());

  @override
  Widget get view => DefaultTabController(length: 2, child: Scaffold(
    appBar: customAppBar(
        title: Text(
          LocaleKeys.order.tr(),
          style: heading5.copyWith(color: AppColors.primary),
        ),
        tabs: TabBar(tabs: [
          Tab(text: "Current Orders",),
          Tab(text: "Order History"),
        ])),
    key: globalKey,
    body: TabBarView(children: [
      _body,
      _body
    ]),
  ));

  get _body => ListView(
    children: [
      _orderItem(),
      _orderItem(),
      _orderItem(),
      _orderItem(),
    ],
  );

  Widget _orderItem() => ControlledWidgetBuilder(builder: (BuildContext context, OrdersController controller) {
    return InkWell(
      onTap: (){
        controller.orderDetails();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(child:
            Padding(
              padding: const EdgeInsets.all(Dimens.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("LQNSU346JK", style: heading5.copyWith(color: AppColors.neutralDark),),
                  Text(LocaleKeys.orderAt.tr(namedArgs: {"location":"India", "date" : "August 1, 2017"}), style: bodyTextNormal2.copyWith(color: AppColors.neutralGray),),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  DotWidget(
                    color: AppColors.neutralLight,
                    width: 8,
                    height: Dimens.borderWidth,
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  Row(
                    children: [
                      Expanded(child: Text(LocaleKeys.orderStatus.tr(), style: bodyTextNormal2.copyWith(color: AppColors.neutralGray),)),
                      Text(LocaleKeys.orderStatusShipping.tr(), style: bodyTextNormal2.copyWith(color: AppColors.neutralDark))
                    ],
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  Row(
                    children: [
                      Expanded(child: Text(LocaleKeys.orderItems.tr(), style: bodyTextNormal2.copyWith(color: AppColors.neutralGray),)),
                      Text(LocaleKeys.fmtItemsPurchased.tr(args: ["1"]), style: bodyTextNormal2.copyWith(color: AppColors.neutralDark))
                    ],
                  ),
                  SizedBox(
                    height: Dimens.spacingMedium,
                  ),
                  Row(
                    children: [
                      Expanded(child: Text(LocaleKeys.price.tr(), style: bodyTextNormal2.copyWith(color: AppColors.neutralGray),)),
                      Text("\$299,43", style: bodyTextNormal1.copyWith(color: AppColors.primary))
                    ],
                  )
                ],
              ),
            )
          ),
      ),
    );
  },);
}
