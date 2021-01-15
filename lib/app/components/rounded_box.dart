import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';

class RoundedBox extends StatelessWidget{
  final Widget child;


  RoundedBox({Widget child}):this.child = child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutralLight,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.cornerRadius))
      ),
      child: child,
    );
  }

}