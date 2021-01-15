import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';

class OutlinedBox extends StatelessWidget{
  final Widget child;


  OutlinedBox({Widget child}):this.child = child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.cornerRadius)),
          border: Border.all(color: AppColors.neutralLight, width: Dimens.borderWidth)
      ),
      child: child,
    );
  }

}