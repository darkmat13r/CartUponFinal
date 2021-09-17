import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Resources {
  static const String login_banner = 'assets/images/login_banner.png';
  static const String login_bg = 'assets/images/login_bg.jpg';
  static const String google_logo = 'assets/images/google_logo.png';
  static const String logo = 'assets/images/logo.png';
  static const String toolbarLogo = 'assets/images/toolbar_logo.png';
  static const String toolbarLogo2 = 'assets/images/toolbar_logo_2.png';
  static const String timerIcon = 'assets/images/icon_timer.png';
  static const String promotion = 'assets/images/promotion.jpg';
  static const String shoe = 'assets/images/shoe.png';
  static const String recommended = 'assets/images/recommended.png';

  static const String mainLogo = "assets/images/main_logo.jpg";

  static const String offerTag = "assets/images/tag.png";
  static const String button = "assets/images/button.png";

  static const String categoryFood = "assets/images/category/food.png";
  static const String categoryDesserts = "assets/images/category/desserts.png";
  static const String categoryAuto = "assets/images/category/automotive.png";
  static const String categoryHealth = "assets/images/category/health.png";
  static const String categoryEntertainment =
      "assets/images/category/entertainment.png";
  static const String categorySports = "assets/images/category/sports.png";
  static const String product1 = "assets/images/category/product_image_1.jpg";
  static const String product2 = "assets/images/category/product_image_2.jpg";
  static const String product3 = "assets/images/category/product_image_3.jpg";
  static const String product4 = "assets/images/category/product_image_4.jpeg";
  static const String product5 = "assets/images/category/product_image_5.jpeg";
  static const String product6 = "assets/images/category/product_image_6.jpeg";
  static const String product7 = "assets/images/category/product_image_7.jpeg";
  static const String product8 = "assets/images/category/product_image_8.jpeg";
  static const String product9 = "assets/images/category/product_image_9.jpeg";
  static const String product10 =
      "assets/images/category/product_image_10.jpeg";
  static const String product11 =
      "assets/images/category/product_image_11.jpeg";
  static const String placeholder = "assets/images/placeholder.gif";

  static String facebook = "assets/images/social/facebook.png";
  static String twitter = "assets/images/social/twitter.png";
  static String whatsapp = "assets/images/social/whatsapp.png";
  static String facebookUrl = "https://www.facebook.com/cartupon";
  static String youtubeUrl = "https://www.youtube.com/";
  static String linkedinUrl = "https://www.linkedin.com/company/cartupon";
  static String instagramUrl = "https://www.instagram.com/cart_upon";
  static String twitterUrl = "https://twitter.com/CartUpon?lang=en";
}

class AppColors {
  static const Color background = const Color(0xFFFCFCFC);
  static const Color primary = const Color(0xff053e7c);
  static const Color accent = const Color(0xff45c2b5);
  static const Color expandableBackground = const Color(0x2245c2b5);
  static const Color neutralLight = const Color(0xffffffff);
  static const Color neutralLightGray = const Color(0xffd9dada);
  static const Color neutralGray = const Color(0xffadafaf);
  static const Color neutralDark = const Color(0xff2f2f2f);
  static const Color error = const Color(0xffFB7181);

  static const Color facebook = const Color(0xff4092FF);

  static var yellow = const Color(0xffFFC833);
  static var warning = const Color(0xffEEA48F);
  static const Color formHintText = const Color(0xff9098B1);
  static const Color formFieldBg = const Color(0xffffffff);
  static const Color cardBg = const Color(0xffFEFEFE);

  static var green = const Color(0xff45c2b5);
}

/// Returns the app's default snackbar with a [text].
SnackBar _getGenericSnackbar(String text, bool isError) {
  return SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: isError ? Colors.red : Colors.white,
        fontSize: 16.0,
      ),
    ),
  );
}


showLoginPopup(BuildContext context,{@required Function onCreate, String guestText,String customMessage, Function onGuestSelected , Function onLoginSelected, Function onRegisterSelected} ){
  showDialog(
      context: context,
      builder: (ctx) {
        onCreate(ctx);
        return AlertDialog(
          title: new Text(
            LocaleKeys.completePurchaseFaster.tr(),
            style: bodyTextMedium1,
          ),
          titlePadding: EdgeInsets.only(
              left: Dimens.spacingMedium,
              right: Dimens.spacingMedium,
              top: Dimens.spacingMedium),
          contentPadding:
          EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
          actionsPadding: EdgeInsets.zero,
          content:  Text(customMessage ?? LocaleKeys.messageSignIn.tr() ,
              style: bodyTextNormal2),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                if(onGuestSelected != null){
                  onGuestSelected(ctx);
                }
              },
              child: Text(
              guestText ??  LocaleKeys.later.tr(),
                style: buttonText.copyWith(color: AppColors.accent),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                if(onLoginSelected != null){
                  onLoginSelected(ctx);
                }
              },
              child: Text(
                LocaleKeys.signIn.tr(),
                style: buttonText.copyWith(color: AppColors.accent),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                if(onRegisterSelected != null){
                  onRegisterSelected(ctx);
                }
              },
              child: Text(
                LocaleKeys.signUp.tr(),
                style: buttonText.copyWith(color: AppColors.accent),
              ),
            )
          ],
        );
      });
}

/// Shows a generic [Snackbar]
void showGenericSnackbar(BuildContext context, String text,
    {bool isError = false}) {
  ScaffoldMessenger.of(context)
      .showSnackBar(_getGenericSnackbar(text, isError));
}

void showGenericDialog(BuildContext context, String title, String message) {
  var dialog = showDialog(
      context: context,
      builder: (ctx) => new AlertDialog(
            title: new Text(title),
            content: new Text(message),
        titlePadding: EdgeInsets.only(
            left: Dimens.spacingMedium,
            right: Dimens.spacingMedium,
            top: Dimens.spacingMedium),
        contentPadding:
        EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
        actionsPadding: EdgeInsets.zero,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text(
                  "OK",
                  style: buttonText.copyWith(color: AppColors.neutralGray),
                ),
              )
            ],
          ));
}

BuildContext _dialogContext;

void showLoadingDialog(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        _dialogContext = ctx;
        return AlertDialog(
          titlePadding: EdgeInsets.only(
              left: Dimens.spacingMedium,
              right: Dimens.spacingMedium,
              top: Dimens.spacingMedium),
          contentPadding:
          EdgeInsets.symmetric(horizontal: Dimens.spacingMedium),
          actionsPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Container(
              width: 80,
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              )),
        );
      });
}

void dismissDialog() {
  if (_dialogContext != null) {
    Navigator.pop(_dialogContext);
    _dialogContext = null;
  }
}

void showGenericConfirmDialog(
    BuildContext context, String title, String message,
    {Function onCancel, Function onConfirm, String confirmText, bool showCancel}) {
  var dialog = showDialog(
      context: context,
      builder: (ctx) =>  WillPopScope(
        onWillPop: () {
          Navigator.pop(ctx);
          if (onCancel != null) {
            onCancel();
          }
          return Future.value(true);
        },
        child: AlertDialog(
              title: title != null ? new Text(title, style: heading6,) : SizedBox(),
              content: new Text(message, style: bodyTextNormal2,),
          titlePadding: EdgeInsets.only(
              left: Dimens.spacingMedium,
              right: Dimens.spacingMedium,
              top: Dimens.spacingMedium),
          contentPadding:
          EdgeInsets.symmetric(horizontal: Dimens.spacingMedium, vertical: Dimens.spacingNormal),
          actionsPadding: EdgeInsets.zero,
              actions: [
                showCancel ?? true ? TextButton(
                  onPressed: () {
                    if (onCancel != null) {
                      onCancel();
                    }
                    Navigator.pop(ctx);
                  },
                  child: Text(
                    LocaleKeys.cancel.tr(),
                    style: buttonText.copyWith(color: AppColors.accent),
                  ),
                ) : SizedBox(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    if (onConfirm != null) {
                      onConfirm();
                    }
                  },
                  child: Text(
                    confirmText != null ? confirmText : LocaleKeys.ok.tr(),
                    style: buttonText.copyWith(color: AppColors.accent),
                  ),
                )
              ],
            ),
      ));
}

class Dimens {
  static const double cornerRadius = 4;
  static const double borderWidth = 1;
  static const double spacingNormal = 8;
  static const double spacingSmall = 4;
  static const double spacingMicro = 4;
  static const double spacingMedium = 16;
  static const double spacingLarge = 24;
  static const double buttonHeight = 52;

  static const double buttonCornerRadius = 56;

  static const double thumbImageHeight = 140;

  static const double elevation = 0;
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
final TextStyle labelText = TextStyle(
    fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.neutralDark);
final TextStyle linkText = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
final TextStyle linkTextSmall =
    TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

final TextStyle formHintText = TextStyle(
    fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.formHintText);
