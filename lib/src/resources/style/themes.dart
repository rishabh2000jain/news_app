import 'package:flutter/material.dart';
import 'package:paper/src/constants/app_constants.dart';
import 'package:paper/src/resources/strings/app_strings.dart';
import 'package:paper/src/resources/values/app_colors.dart';

class AppThemes {
  static ThemeData getLightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColor.whiteColor,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.black, circularTrackColor: Colors.black12),
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Colors.white, iconTheme: IconThemeData(color: Colors.black)),
      cardTheme: CardTheme(
        margin: AppConstants.kEdgeIsets10,
        color: Colors.white,
        clipBehavior: Clip.hardEdge,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      chipTheme: ChipThemeData.fromDefaults(
        secondaryColor: Colors.red,
        primaryColor: Colors.black,
        labelStyle: const TextStyle(
            color: AppColor.whiteColor, fontWeight: FontWeight.w900),
      ),
      textTheme: const TextTheme(
        headline5: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontFamily: AppStrings.kPlayfairDisplayFont),
        headline6: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 21,
            color: Colors.white,
            overflow: TextOverflow.ellipsis),
        bodyText1: TextStyle(
          fontSize: 22.0,
          color: Colors.black26,
        ),
        bodyText2: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      colorScheme: const ColorScheme.light(
        primaryVariant: AppColor.blackVariant,
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColor.blackVariant,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white, circularTrackColor: Colors.white12),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      textTheme: const TextTheme(
        headline5: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontFamily: AppStrings.kPlayfairDisplayFont),
        headline6: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.white,
            fontSize: 21,
            overflow: TextOverflow.ellipsis),
        bodyText2: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        bodyText1: TextStyle(
          fontSize: 22.0,
          color: Colors.white70,
        ),
      ),
      cardTheme: CardTheme(
        margin: AppConstants.kEdgeIsets10,
        color: Colors.black54,
        clipBehavior: Clip.hardEdge,
        shadowColor: Colors.white70,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      chipTheme: ChipThemeData.fromDefaults(
        primaryColor: Colors.white,
        secondaryColor: Colors.lightBlueAccent,
        labelStyle: const TextStyle(
            color: AppColor.whiteColor, fontWeight: FontWeight.w900),
      ),
      colorScheme: const ColorScheme.dark(
        primaryVariant: AppColor.whiteColor,
      ),
    );
  }
}
