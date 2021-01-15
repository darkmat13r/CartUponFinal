import 'package:coupon_app/app/components/dotted_view.dart';
import 'package:coupon_app/app/components/outlined_box.dart';
import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/components/product_thumbnail.dart';
import 'package:coupon_app/app/pages/order/order_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:easy_localization/easy_localization.dart';
class OrderPage extends View{
  @override
  State<StatefulWidget> createState()=> OrderPageState();

}

class OrderPageState extends ViewState<OrderPage, OrderController>{
  OrderPageState() : super(OrderController());

  @override
  Widget get view => Scaffold(
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(onPressed: () {

      }, icon: Icon(Feather.chevron_left, color: AppColors.neutralGray),
      ),
      title: Text(
        LocaleKeys.orderDetails.tr(),
        style: heading4.copyWith(color: AppColors.neutralDark),
      ),
      shape: appBarShape,
    ),
    key: globalKey,
    body: _body,
  );

  get _body => ListView(
    children: [
      SizedBox(
        height: Dimens.spacingMedium,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal  : Dimens.spacingMedium),
        child: Text(LocaleKeys.product.tr(), style: heading5.copyWith(color: AppColors.neutralDark),),
      ),
      _product(),
      SizedBox(
        height: Dimens.spacingNormal,
      ),
      _product(),
      SizedBox(
        height: Dimens.spacingMedium,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal  : Dimens.spacingMedium),
        child: Text(LocaleKeys.shippingDetails.tr(), style: heading5.copyWith(color: AppColors.neutralDark),),
      ),
      _shippingDetails(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal  : Dimens.spacingMedium),
        child: Text(LocaleKeys.paymentDetails.tr(), style: heading5.copyWith(color: AppColors.neutralDark),),
      ),
      _paymentDetails()
    ],
  );
  Widget _paymentDetails(){
    return Padding(
      padding: const EdgeInsets.all(Dimens.spacingNormal),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingMedium),
          child: Column(
            children: [
              _detailItem(LocaleKeys.items.tr(args: ["3"]) , "\$569.78"),
              _detailItem(LocaleKeys.shipping.tr(), "\$40.00"),
              DotWidget(color: AppColors.neutralGray,),
              _detailItem(LocaleKeys.totalPrice.tr(),  "\$40.00"),
            ],
          ),
        ),
      ),
    );
  }
  Widget _shippingDetails(){
    return Padding(
      padding: const EdgeInsets.all(Dimens.spacingNormal),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingMedium),
          child: Column(
            children: [
              _detailItem(LocaleKeys.orderShippingDate.tr(), "January 12, 2021"),
              _detailItem(LocaleKeys.address.tr(), "2727 Lakeshore Rd undefined Nampa, Tennessee 78410"),
              _detailItem(LocaleKeys.orderStatus.tr(), LocaleKeys.orderStatusShipping.tr()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailItem(name, value){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.spacingNormal),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex:1,child: Text(name, style: bodyTextNormal2.copyWith(color: AppColors.neutralGray),)),
          Expanded(
            child: SizedBox(
            ),
          ),
          Expanded(flex:1,child: Text(value, textAlign: TextAlign.end,style: bodyTextNormal2.copyWith(color: AppColors.neutralDark)))
        ],
      ),
    );
  }
  Widget _product(){
    return ControlledWidgetBuilder(builder: (BuildContext context, OrderController controller) {
      return  InkWell(
        onTap: (){
          controller.product();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal  :  Dimens.spacingNormal),
          child: Card(child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMedium),
            child: Row(
              children: [
                ProductThumbnail(),
                SizedBox(
                  width: Dimens.spacingMedium,
                ),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nike Air Zoom Pegasus 36 Miami", style: heading6.copyWith(color:
                    AppColors.neutralDark),),
                    SizedBox(
                      height: Dimens.spacingMedium,
                    ),
                    Text("\$430,99", style: heading6.copyWith(color:
                    AppColors.primary),),
                  ],
                ))
              ],
            ),
          ),),
        ),
      );
    },);
  }
}