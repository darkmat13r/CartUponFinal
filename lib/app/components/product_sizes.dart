import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductSizes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [6, 6.5, 7, 8, 9]
            .map((e) => Padding(
              padding: const EdgeInsets.fromLTRB(0,0,8.0,0),
              child: SizedBox(
          width: 60,
              height: 60,
                child: Ink(
          decoration: const ShapeDecoration(
                  shape: const CircleBorder(
                      side: BorderSide(
                          width: Dimens.borderWidth,
                          color: AppColors.neutralLight))),
          child: Center(child: Text(e.toString(),style: heading5.copyWith(color: AppColors.neutralDark),)),
        ),
              ),
            ))
            .toList(),
      ),
    );
  }
}
