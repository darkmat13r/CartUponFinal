import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupon_app/app/components/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomImage extends StatefulWidget{
  final String url;
  ZoomImage(this.url);
  @override
  State<StatefulWidget> createState() => _ZoomImageState();

}

class _ZoomImageState extends State<ZoomImage>{
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: customAppBar(),
      body: Container(
          child: PhotoView(
            imageProvider: NetworkImage(widget.url),
          )
      ),
    );
  }

}