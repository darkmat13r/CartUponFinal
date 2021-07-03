import 'dart:convert';

import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage  extends StatefulWidget{
  final String page;
  final String title;

  WebPage({this.page, this.title});

  @override
  State<StatefulWidget> createState() => _WebPageState();

}

class _WebPageState extends State<WebPage>{
  WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title, style: heading5.copyWith(color: AppColors.primary),),),
      body:  WebView(
        initialUrl:
        'about:blank',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController w) {
          webViewController = w;
          _loadHtmlFromAssets();
        },
      )
    );
  }
  _loadHtmlFromAssets() async {
   var locale = Config().locale ?? Locale('en');
    String fileText = await rootBundle.loadString('assets/html/${locale.languageCode}/${widget.page}');
    webViewController.loadUrl( Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }
}