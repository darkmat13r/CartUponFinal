import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _borderSide =
    BorderSide(color: AppColors.neutralLight, width: Dimens.borderWidth);
const _errorBorderSide =
    BorderSide(color: AppColors.error, width: Dimens.borderWidth);
const _focusedBorderSide =
    BorderSide(color: AppColors.primary, width: Dimens.borderWidth);

ThemeData appTheme(BuildContext context) => ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
    outlinedButtonTheme: OutlinedButtonThemeData(),
    buttonTheme: ButtonThemeData(
        height: Dimens.buttonHeight,
        buttonColor: AppColors.accent,
        textTheme: ButtonTextTheme.primary,

        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(Dimens.cornerRadius)))),
    cardTheme: CardTheme(
        elevation: 0,
        color: AppColors.background,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(Dimens.cornerRadius)),
            side: _borderSide)),
    textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.primary),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: formText,
        helperStyle: formText,
        hintStyle: formText,
        contentPadding: EdgeInsets.symmetric(vertical: Dimens.spacingSmall),
        focusColor: AppColors.primary,
        prefixStyle: TextStyle(color: AppColors.primary),
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
            borderRadius: BorderRadius.circular(Dimens.cornerRadius))));
