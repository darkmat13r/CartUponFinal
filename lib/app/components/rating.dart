
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Rating extends StatefulWidget{

  final double size ;

  Rating({this.size = 14});

  @override
  State<StatefulWidget> createState()  => RatingState();
}


class RatingState extends State<Rating>{
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Octicons.star,
          color: AppColors.yellow,
          size: widget.size,
        ),
        Icon(
          Octicons.star,
          color: AppColors.yellow,
          size: widget.size,
        ),
        Icon(
          Octicons.star,
          color: AppColors.yellow,
          size: widget.size,
        ),
        Icon(
          Octicons.star,
          color: AppColors.yellow,
          size: widget.size,
        ),
        Icon(
          Octicons.star,
          color: AppColors.neutralLight,
          size: widget.size,
        ),
      ],
    );
  }
}