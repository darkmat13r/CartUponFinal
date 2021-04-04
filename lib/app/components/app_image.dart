import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppImage extends StatefulWidget {
  String url;

  AppImage(this.url);

  @override
  State<StatefulWidget> createState() => _AppImageState();


}

class _AppImageState extends State<AppImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: CachedNetworkImage(
          placeholder: (context, url) =>  Image.asset(Resources.placeholder),
          imageUrl: widget.url,
          errorWidget: (context, url, error) =>Image.asset(Resources.placeholder),
        ));
  }


}