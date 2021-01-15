import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Resources {
  static const String login_banner = 'assets/images/login_banner.png';
  static const String google_logo = 'assets/images/google_logo.png';
  static const String logo = 'assets/images/logo.png';
  static const String promotion = 'assets/images/promotion.jpg';
  static const String shoe = 'assets/images/shoe.png';
  static const String recommended = 'assets/images/recommended.png';
}

class AppColors {
  static const Color background = const Color(0xFFFFFFFF);
  static const Color primary = const Color(0xff04407F);
  static const Color accent = const Color(0xff04407F);
  static const Color neutralLight = const Color(0xffEBF0FF);
  static const Color neutralGray = const Color(0xff9098B1);
  static const Color neutralDark = const Color(0xff223263);
  static const Color error = const Color(0xffFB7181);

  static const Color facebook = const Color(0xff4092FF);

  static var yellow = const Color(0xffFFC833);
}

class Dimens {
  static const double cornerRadius = 8;
  static const double borderWidth = 2;
  static const double spacingNormal = 8;
  static const double spacingSmall = 4;
  static const double spacingMicro = 4;
  static const double spacingMedium = 16;
  static const double spacingLarge = 24;
  static const double buttonHeight = 57;
}

final TextStyle heading1 = TextStyle(fontSize: 36, fontWeight: FontWeight.bold);
final TextStyle heading2 = TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
final TextStyle heading3 = TextStyle(fontSize: 26, fontWeight: FontWeight.bold);
final TextStyle heading4 = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
final TextStyle heading5 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
final TextStyle heading6 = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
final TextStyle bodyTextLarge1 =
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
final TextStyle bodyTextLarge2 =
    TextStyle(fontSize: 20, fontWeight: FontWeight.normal);
final TextStyle bodyTextMedium1 =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
final TextStyle bodyTextMedium2 =
    TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

final TextStyle bodyTextNormal1 =
    TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
final TextStyle bodyTextNormal2 = TextStyle(
    fontSize: 14, color: AppColors.neutralGray, fontWeight: FontWeight.normal);

final TextStyle captionLarge1 =
    TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
final TextStyle captionLarge2 =
    TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
final TextStyle captionNormal1 =
    TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
final TextStyle captionNormal2 =
    TextStyle(fontSize: 12, fontWeight: FontWeight.normal);

final TextStyle buttonText =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);

final TextStyle formText =
    TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
final TextStyle linkText = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
final TextStyle linkTextSmall =
    TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
