import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';

class RoundedBox extends StatelessWidget{
  final Widget child;
  final Color color;


  RoundedBox({Widget child, this.color}):this.child = child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? AppColors.neutralLight,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.cornerRadius))
      ),
      child: child,
    );
  }

}