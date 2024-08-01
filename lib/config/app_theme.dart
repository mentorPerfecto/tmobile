import 'package:tampay/src/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  AppTheme._();
  static final _instance = AppTheme._();
  static AppTheme get instance => _instance;

  static ThemeData lightTheme = ThemeData(
    dividerColor: AppColors.kDisabledButton,
    brightness: Brightness.light,
    primarySwatch: Colors.blue,

    fontFamily: soraFont,
    canvasColor: AppColors.kWhite,
    colorScheme: ColorScheme.fromSeed(
      errorContainer: AppColors.kErrorContainer,
      surface: AppColors.kTransparent,
      seedColor: Colors.white,
      primary: AppColors.kGrey900,
      surfaceTint: Colors.white,
      error: AppColors.kErrorPrimary,
      secondary: AppColors.kGrey800,
      outline: AppColors.kDisabledButton,
      onPrimaryContainer: AppColors.kFadedBlue,
      tertiary: AppColors.kAshBlue,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.red),
    primaryColor: AppColors.kPrimary1,
    indicatorColor: AppColors.kPrimary2,
    cardColor: AppColors.kWhite,
    // canvasColor: AppColors.lightCanvasColor,
    // dividerColor: AppColors.lightDividerColor,
    // dialogBackgroundColor: AppColors.lightBackgroundColor,
    scaffoldBackgroundColor: AppColors.kLightModebackground,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // colorScheme: const ColorScheme.light(
    //     secondary: AppColors.lightSecondaryColor,
    //     primary: AppColors.lightSecondaryColor,
    //     background: AppColors.lightBackgroundColor,
    //     brightness: Brightness.light),
    // checkboxTheme: ThemeData.light().checkboxTheme.copyWith(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(3),
    //       ),

    //     ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      titleTextStyle: ThemeData.light()
          .textTheme
          .titleLarge!
          .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
      iconTheme: ThemeData.light().iconTheme,
      color: AppColors.kTransparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 22.spMin,
        fontWeight: FontWeight.w600,
        fontFamily: soraFont,
        color: AppColors.kGrey900,
      ),
      titleMedium: TextStyle(
        fontFamily: soraFont,
        fontSize: 12.spMin,
        fontWeight: FontWeight.w400,
        color: AppColors.kGrey900,
      ),
      headlineSmall: TextStyle(
        fontSize: 30.spMin,
        fontWeight: FontWeight.w600,
        fontFamily: soraFont,
        color: AppColors.kGrey900,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.spMin,
        fontWeight: FontWeight.w400,
        fontFamily: soraFont,
        color: AppColors.kGrey900,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    bottomSheetTheme: BottomSheetThemeData(
      modalBarrierColor: AppColors.kTransparent,
    ),
    hintColor: AppColors.kDesaturatedDarkBlue,
    primaryColorLight: AppColors.kPrimary150,
    cardColor: AppColors.kContainerBackground,
    brightness: Brightness.dark,
    primaryColor: AppColors.kPrimary1,
    dividerColor: AppColors.kDarkDividerColor,
    scaffoldBackgroundColor: AppColors.kCharcoalBlack,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: soraFont,
    colorScheme: const ColorScheme.dark(
        secondary: AppColors.kDarkSecondary,
        primary: AppColors.kTextWhite,
        surface: AppColors.kBackgroundDark,
        tertiary: AppColors.kTextDark,
        brightness: Brightness.dark),
    checkboxTheme: ThemeData.dark().checkboxTheme.copyWith(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
    indicatorColor: AppColors.kPrimary150,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      titleTextStyle: ThemeData.dark()
          .textTheme
          .titleLarge!
          .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
      iconTheme: ThemeData.dark().iconTheme,
      color: AppColors.kPrimary1Dark,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20.spMin,
        fontWeight: FontWeight.w600,
        fontFamily: soraFont,
        color: AppColors.kTextWhite,
      ),
      titleMedium: TextStyle(
        fontFamily: soraFont,
        fontSize: 12.spMin,
        fontWeight: FontWeight.w400,
        color: AppColors.kGrey400,
      ),
      headlineSmall: TextStyle(
        fontSize: 30.spMin,
        fontWeight: FontWeight.w600,
        fontFamily: soraFont,
        color: AppColors.kTextWhite,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.spMin,
        fontWeight: FontWeight.w400,
        fontFamily: soraFont,
        color: AppColors.kTextWhite,
      ),
    ),
  );

  // static ThemeData darkTheme = ThemeData(
  //   brightness: Brightness.dark,
  //   // primaryColor: AppColors.darkPrimaryColor,
  //   // canvasColor: AppColors.darkCanvasColor,
  //   // dividerColor: AppColors.darkDividerColor,
  //   // dialogBackgroundColor: AppColors.darkBackgroundColor,
  //   // scaffoldBackgroundColor: AppColors.darkBackgroundColor,
  //   // visualDensity: VisualDensity.adaptivePlatformDensity,
  //   // fontFamily: 'Satoshi',
  //   // colorScheme: const ColorScheme.dark(
  //   //     secondary: AppColors.darkSecondaryColor,
  //   //     primary: AppColors.darkSecondaryColor,
  //   //     background: AppColors.darkBackgroundColor,
  //   //     brightness: Brightness.dark),
  //   // checkboxTheme: ThemeData.dark().checkboxTheme.copyWith(
  //   //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
  //   //     ),
  //   appBarTheme: AppBarTheme(
  //     elevation: 0.0,
  //     titleTextStyle: ThemeData.dark()
  //         .textTheme
  //         .titleLarge!
  //         .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
  //     iconTheme: ThemeData.dark().iconTheme,
  //     // color: AppColors.darkPrimaryColor,
  //     systemOverlayStyle: const SystemUiOverlayStyle(
  //       statusBarBrightness: Brightness.dark,
  //       statusBarIconBrightness: Brightness.dark,
  //     ),
  //   ),
  // );
}
