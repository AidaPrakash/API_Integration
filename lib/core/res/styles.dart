import 'package:flutter/material.dart';
import 'package:pon/core/res/colors.dart';
import 'package:pon/core/res/fontsize.dart';

class AppStyle {
  static final ThemeData appTheme = ThemeData(
    primaryColor: AppColor.primary,
    primaryColorDark: AppColor.primaryDark,
    accentColor: AppColor.accent,
    dividerColor: AppColor.divider,
    brightness: Brightness.light,
    indicatorColor: AppColor.primaryDark,
    textTheme: TextTheme(
        headline6: TextStyle(
          color: AppColor.text,
        ),
        headline5: TextStyle(color: AppColor.header),
        subtitle1: TextStyle(color: AppColor.secondaryHeader),
        button: TextStyle(color: AppColor.primary)),
    primaryIconTheme:
        const IconThemeData.fallback().copyWith(color: AppColor.primary),
    appBarTheme: const AppBarTheme().copyWith(
        color: AppColor.scaffoldBackground,
        elevation: 0,
        textTheme:
            const TextTheme().copyWith(headline6: AppTextStyle.appBarTitle),
        iconTheme: const IconThemeData().copyWith(color: AppColor.primary)),
    backgroundColor: AppColor.background,
    fontFamily: "Nunito",
    scaffoldBackgroundColor: AppColor.scaffoldBackground,
  );

  static List<BoxShadow> cardShadow = [
    BoxShadow(color: Colors.black12, spreadRadius: 0.1, blurRadius: 3.5),
  ];

  static final List<BoxShadow> mildCardShadow = [
    BoxShadow(color: AppColor.shadowColor, spreadRadius: 0.1, blurRadius: 10),
  ];

  static final LinearGradient linearGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        AppColor.backgroundGradient1,
        AppColor.backgroundGradient2,
        AppColor.backgroundGradient3
      ]);

  static final LinearGradient linearGradientHeader = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        AppColor.indicatorColor1,
        AppColor.indicatorColor1,
        AppColor.indicatorColor1
      ]);
}

class AppTextStyle {
  static const TextStyle appBarTitle = TextStyle(
    fontSize: AppFontSize.xlarge,
    fontWeight: FontWeight.bold,
    color: AppColor.header,
  );

  static const TextStyle header = TextStyle(
    fontSize: AppFontSize.xlarge,
    fontWeight: FontWeight.bold,
    color: AppColor.header,
  );

  static const TextStyle subHeader = TextStyle(
    fontSize: AppFontSize.largest,
    fontWeight: FontWeight.w600,
    color: AppColor.header,
  );

  static const TextStyle body = TextStyle(
      fontSize: AppFontSize.small,
      fontWeight: FontWeight.normal,
      color: AppColor.header,
      height: 1.5);

  static const TextStyle button = TextStyle(
    fontSize: AppFontSize.largest,
    fontWeight: FontWeight.w600,
    color: AppColor.white,
  );

  static const TextStyle buttonOutline = TextStyle(
    fontSize: AppFontSize.largest,
    fontWeight: FontWeight.w600,
    color: AppColor.primary,
  );

  static const TextStyle buttonTextSecondary = TextStyle(
    fontSize: AppFontSize.small,
    fontWeight: FontWeight.normal,
    color: AppColor.white,
  );

  static const TextStyle buttonSecondary = TextStyle(
    fontSize: AppFontSize.normal,
    fontWeight: FontWeight.w600,
    color: AppColor.secondary,
  );

  static const TextStyle dialogButtonOutline = TextStyle(
    fontSize: AppFontSize.small,
    fontWeight: FontWeight.normal,
    color: AppColor.primary,
  );

  static const TextStyle dialogButton = TextStyle(
    fontSize: AppFontSize.small,
    fontWeight: FontWeight.normal,
    color: AppColor.primary,
  );

  static const TextStyle label = TextStyle(
      fontSize: AppFontSize.small,
      fontWeight: FontWeight.normal,
      color: AppColor.secondaryText,
      height: 1.5);

  static const TextStyle text = TextStyle(
      fontSize: AppFontSize.large,
      fontWeight: FontWeight.normal,
      color: AppColor.text,
      height: 1.5);

  static const TextStyle dashtext = TextStyle(
      fontSize: AppFontSize.small,
      fontWeight: FontWeight.normal,
      color: AppColor.text,
      height: .15);

  static const TextStyle title = TextStyle(
      fontSize: AppFontSize.large,
      fontWeight: FontWeight.w600,
      color: AppColor.primaryDark,
      height: 1.5);

  static const TextStyle largest = TextStyle(
    fontSize: AppFontSize.largest,
    fontWeight: FontWeight.bold,
    color: AppColor.text,
  );

  static const TextStyle footer = TextStyle(
      fontSize: AppFontSize.smallest,
      fontWeight: FontWeight.w600,
      color: AppColor.primaryDark,
      height: 1.5);

  static const TextStyle btnfooter = TextStyle(
      backgroundColor: AppColor.blue,
      fontSize: AppFontSize.xlarge,
      fontWeight: FontWeight.w900,
      color: AppColor.primaryDark,
      height: 1.5);
}
