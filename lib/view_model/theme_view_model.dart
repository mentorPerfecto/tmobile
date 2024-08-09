import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampay/config/app_colors.dart';
import 'package:tampay/model/local/dummy_data.dart';
import 'package:tampay/src/utils.dart';

final themeViewModel = ChangeNotifierProvider((ref) => ThemeConfig());

class ThemeConfig extends ChangeNotifier {
  // ThemeConfig._();
  //
  // static final _instance = ThemeConfig._();
  // static ThemeConfig get instance => _instance;

  // ThemeMode _themeMode = ThemeMode.dark;

  late SharedPreferences sharedPreferences;

  List<String> modes = ["Light Mode", "Dark Mode", "System Mode"];

  ThemeMode _themeMode = ThemeMode.light;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    DummyData.isDarkTheme = sharedPreferences.getBool("isDarkTheme") ?? true;
    DummyData.appTheme = sharedPreferences.getString("AppTheme") ?? "Dark Mode" ;

    logger.w( DummyData.isDarkTheme );
    logger.w( DummyData.appTheme );

    sharedPreferences.setBool('isDarkTheme',DummyData.isDarkTheme );
    sharedPreferences.setString('AppTheme', DummyData.appTheme.toString());
    _themeMode = DummyData.appTheme!.isEmpty || DummyData.appTheme!.toString() == 'System Mode'?
    ThemeMode.system : DummyData.appTheme!.toString() == 'Dark Mode'?  ThemeMode.dark : ThemeMode.light;


    setThemeMode( _themeMode == ThemeMode.dark ?  ThemeMode.dark :  ThemeMode.light);
    DummyData.accessToken = sharedPreferences.getString("accessToken");
    notifyListeners();
  }

  String selectAppTheme (String val) {
    DummyData.appTheme = val ;
    notifyListeners();
    return DummyData.appTheme.toString();

  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;


    _setStatusBar();
    notifyListeners();
  }

  void _setStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: _themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      statusBarColor: _themeMode == ThemeMode.light ? AppColors.kWhite :  AppColors.kCharcoalBlack ,
      systemNavigationBarColor: _themeMode == ThemeMode.light ? AppColors.kWhite :  AppColors.kCharcoalBlack ,
      statusBarIconBrightness: _themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,

    ));
  }

  ThemeMode get themeMode => _themeMode;
}
