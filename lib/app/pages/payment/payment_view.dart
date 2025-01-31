import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:coupon_app/app/pages/payment/payment_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/data/repositories/data_authentication_repository.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class PaymentPage extends View {
  String paymentUrl;
  bool wallet;

  PaymentPage(this.paymentUrl, {bool wallet}) : this.wallet = wallet ?? false;

  @override
  State<StatefulWidget> createState() => _PaymentPageState();
}

class _PaymentPageState extends ViewState<PaymentPage, PaymentController> {
  _PaymentPageState()
      : super(PaymentController(DataAuthenticationRepository())) {}



  @override
  Widget get view => ControlledWidgetBuilder(builder: (BuildContext context, PaymentController controller){
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(title: Text(LocaleKeys.payment.tr(), style: heading5.copyWith(color: AppColors.primary),)),
        key: globalKey,

        body: _body,
      ),
    );
  });

  get _body => ControlledWidgetBuilder(
          builder: (BuildContext context, PaymentController controller) {
        return Stack(
          children: [
            WebView(
              initialUrl:
              widget.paymentUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController w) {
                controller.webViewController = w;
              },
              onPageFinished: (finish){
                controller.dismissLoading();
              },
              javascriptChannels: Set.from([
                JavascriptChannel(
                    name: 'App',
                    onMessageReceived: (JavascriptMessage message) {
                      //This is where you receive message from
                      //javascript code and handle in Flutter/Dart
                      //like here, the message is just being printed
                      //in Run/LogCat window of android studio
                      Logger().e(message.message);
                      controller.processResponse(message.message, widget.wallet);
                    })
              ]),
            ),
            controller.isLoading ? Center( child: CircularProgressIndicator(),)
                : Stack(),
          ],
        );
      });
}
