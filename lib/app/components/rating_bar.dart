import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:logger/logger.dart';

class RatingBar extends StatefulWidget {

  final double size;
  final int initialRating;

  Function onRatingChange;

  RatingBar({this.size = 14, this.onRatingChange, this.initialRating});

  @override
  State<StatefulWidget> createState() => _RatingBarState();
}


class _RatingBarState extends State<RatingBar> {
  int rating = 0;


  @override
  Widget build(BuildContext context) {
 //   rating =  widget.initialRating ??0;
    if(widget.initialRating != null ){
      rating =  widget.initialRating ??0;
    }
    return Row(
      children: List.generate(5, (index) =>
          InkWell(
            onTap: () {
              setState(() {
                rating = index + 1;
                Logger().e("New Rating ${index} ${ index < rating}");
                if (widget.onRatingChange != null)
                  widget.onRatingChange(rating);
              });
            },
            child: Icon(
              Octicons.star,
              color: index < rating ? AppColors.yellow : AppColors.neutralGray,
              size: widget.size,
            ),
          )),
    );
  }
}

/*
[
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
color: AppColors.neutralGray,
size: widget.size,
),
]*/
