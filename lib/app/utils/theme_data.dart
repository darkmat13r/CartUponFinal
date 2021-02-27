import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _borderSide =
    BorderSide(color: AppColors.neutralGray, width: Dimens.borderWidth);
const _errorBorderSide =
    BorderSide(color: AppColors.error, width: Dimens.borderWidth);
const _focusedBorderSide =
    BorderSide(color: AppColors.primary, width: Dimens.borderWidth);
const appBarShape = RoundedRectangleBorder(
    side: BorderSide(
        color: AppColors.neutralLight, width: Dimens.borderWidth));

TextTheme createTextTheme(BuildContext context) =>
    GoogleFonts.amaranteTextTheme(Theme.of(context).textTheme).copyWith(
      overline: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.normal,
          color: AppColors.neutralDark,
          letterSpacing: 1.5),
      caption: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppColors.neutralDark,
          letterSpacing: 0.4),
      button: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.neutralDark,
          letterSpacing: 1.25),
      bodyText2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.neutralDark,
          letterSpacing: 0.25),
      bodyText1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.neutralDark,
          letterSpacing: 0.5),
      subtitle2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.neutralDark,
          letterSpacing: 0.1),
      subtitle1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.neutralDark,
          letterSpacing: 0.15),
      headline6: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.neutralDark,
          letterSpacing: 0.15),
      headline5: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal,
          color: AppColors.neutralDark,
          letterSpacing: 0),
      headline4: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.normal,
          color: AppColors.neutralDark,
          letterSpacing: 0.25),
      headline3: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.normal,
          color: AppColors.neutralDark,
          letterSpacing: 0),
      headline2: TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.w200,
          color: AppColors.neutralDark,
          letterSpacing: -0.5),
      headline1: TextStyle(
          fontSize: 96,
          fontWeight: FontWeight.w200,
          color: AppColors.neutralDark,
          letterSpacing: -1.5),
    );

ThemeData appTheme(BuildContext context) => ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  dialogBackgroundColor: AppColors.background,
  backgroundColor: AppColors.background,
  primaryColor: AppColors.primary,
  brightness: Brightness.light,
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.cardBg,
    actionTextColor: AppColors.neutralDark,
  ),
  appBarTheme: AppBarTheme(
    color: AppColors.neutralLight,
    iconTheme: IconThemeData(
      color: AppColors.primary
    ),
    toolbarTextStyle:  heading4.copyWith(color: AppColors.primary),
    titleTextStyle: heading4.copyWith(color: AppColors.primary),
  ),
  textTheme: GoogleFonts.amaranthTextTheme(),
  outlinedButtonTheme: OutlinedButtonThemeData(),
  buttonTheme: ButtonThemeData(
      height: Dimens.buttonHeight,
      buttonColor: AppColors.accent,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(Dimens.buttonCornerRadius)))),
  cardTheme: CardTheme(
      color: AppColors.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.all(Radius.circular(Dimens.cornerRadius)),
      )),
  textSelectionTheme:
  TextSelectionThemeData(cursorColor: AppColors.primary),
  inputDecorationTheme: InputDecorationTheme(
      labelStyle: formText,
      helperStyle: formText,
      hintStyle: formHintText,
      contentPadding: EdgeInsets.symmetric(
          vertical: Dimens.spacingSmall, horizontal: Dimens.spacingMedium),
      focusColor: AppColors.neutralGray,
      fillColor: AppColors.formFieldBg,
      filled: true,
      prefixStyle: TextStyle(color: AppColors.accent),
      errorStyle: TextStyle(
          color: AppColors.error,
          fontSize: null,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal),
      errorBorder: OutlineInputBorder(
          borderSide: _errorBorderSide,
          borderRadius: BorderRadius.circular(Dimens.cornerRadius)),
      focusedBorder: OutlineInputBorder(
          borderSide: _focusedBorderSide,
          borderRadius: BorderRadius.circular(Dimens.cornerRadius)),
      enabledBorder: OutlineInputBorder(
          borderSide: _borderSide,
          borderRadius: BorderRadius.circular(Dimens.cornerRadius))),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.background,
    elevation: 0,
    unselectedItemColor: AppColors.primary,
    selectedItemColor: AppColors.accent,
  ),
);
