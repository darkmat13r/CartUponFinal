import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppImage extends StatefulWidget {
  String url;
  BoxFit fit;

  AppImage(this.url, {this.fit});

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
        height: MediaQuery
            .of(context)
            .size
            .width,

        child: CachedNetworkImage(
          placeholder: (context, url) =>  Image.asset(Resources.placeholder , fit: BoxFit.cover,),
          imageUrl: widget.url,
          fit: widget.fit != null ? widget.fit : BoxFit.cover,
          errorWidget: (context, url, error) => Container(
            child: Image.asset(Resources.placeholder , fit: BoxFit.cover,),
          ),
        ));
  }


}