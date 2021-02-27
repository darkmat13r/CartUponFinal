import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SocialShareButtons extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SocialShareButtonState();

}

class _SocialShareButtonState extends State<SocialShareButtons>{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){},
          child: Container(
            child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(Resources.facebook, width: 24,),
            ),
          ),
        ),
        InkWell(
          onTap: (){},
          child: Container(
            child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(Resources.twitter, width: 24,),
            ),
          ),
        ),
        InkWell(
          onTap: (){},
          child: Container(
            child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(Resources.whatsapp, width: 24,),
            ),
          ),
        ),
        InkWell(
          onTap: (){},
          child: Container(
            child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(MaterialCommunityIcons.share_variant, size: 24, color: AppColors.accent,),
            ),
          ),
        )
      ],
    );
  }


}