import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/components/dotted_view.dart';
import 'package:coupon_app/app/components/outlined_box.dart';
import 'package:coupon_app/app/components/state_view.dart';
import 'package:coupon_app/app/pages/orders/orders_controller.dart';
import 'package:coupon_app/app/pages/orders/orders_view.dart';
import 'package:coupon_app/app/pages/orders/tab/order_tabbed_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:coupon_app/data/repositories/data_order_repository.dart';
import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_icons/flutter_icons.dart';

class OrdersTabbedPage extends View {


  OrdersTabbedPage() ;

  @override
  State<StatefulWidget> createState() => _OrdersPageState();

}


class _OrdersPageState extends ViewState<OrdersTabbedPage, OrderTabbedController> {
  _OrdersPageState() : super(OrderTabbedController());

  @override
  Widget get view => DefaultTabController(length: 2, child: Scaffold(
    appBar: customAppBar(
        title: Text(
          LocaleKeys.order.tr(),
          style: heading5.copyWith(color: AppColors.primary),
        ),
        tabs: TabBar(tabs: [
          Tab(text: LocaleKeys.currentOrders.tr(),),
          Tab(text: LocaleKeys.orderHistory.tr()),
        ])),
    key: globalKey,
    body: TabBarView(children: [
      OrdersPage("pending"),
      OrdersPage("completed"),
    ]),
  ));




}
