import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SocialShareButtons extends StatefulWidget{
  Function onShare;

  SocialShareButtons({this.onShare});

  @override
  State<StatefulWidget> createState() => _SocialShareButtonState();

}
class SocialShareType{
  static const FACEBOOK = 1;
  static const TWITTER = 2;
  static const WHATSAPP = 3;
  static const TEXT = 4;
}
class _SocialShareButtonState extends State<SocialShareButtons>{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
            widget.onShare();
          },
          child: Container(
            child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(Resources.facebook, width: 24,),
            ),
          ),
        ),
        InkWell(
          onTap:   (){
            widget.onShare();
          },
          child: Container(
            child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(Resources.twitter, width: 24,),
            ),
          ),
        ),
        InkWell(
          onTap:  widget.onShare,
          child: Container(
            child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(Resources.whatsapp, width: 24,),
            ),
          ),
        ),
        InkWell(
          onTap:  widget.onShare,
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