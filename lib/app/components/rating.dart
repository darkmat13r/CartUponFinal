import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Rating extends StatefulWidget {

  final double size;

  Function onRatingChange;

  Rating({this.size = 14, this.onRatingChange});

  @override
  State<StatefulWidget> createState() => _RatingState();
}


class _RatingState extends State<Rating> {
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) =>
          InkWell(
            onTap: () {
              setState(() {
                rating = index + 1;
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
