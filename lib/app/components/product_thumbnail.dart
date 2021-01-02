import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';

class ProductThumbnail extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ProductThumbnailState();

}

class ProductThumbnailState extends State<ProductThumbnail>{
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
            borderRadius: const BorderRadius.all(
                Radius.circular(12)),
            color: AppColors.neutralLight),
        child: Image(
          width: double.infinity,
          image: AssetImage(Resources.shoe),
        ));
  }

}