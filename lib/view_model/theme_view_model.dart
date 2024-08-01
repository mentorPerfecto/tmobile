import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampay/model/local/dummy_data.dart';

final themeViewModel = ChangeNotifierProvider((ref) => ThemeConfig());

class ThemeConfig extends ChangeNotifier {
  // ThemeConfig._();
  //
  // static final _instance = ThemeConfig._();
  // static ThemeConfig get instance => _instance;

  // ThemeMode _themeMode = ThemeMode.dark;

  late SharedPreferences sharedPreferences;

  ThemeMode _themeMode = ThemeMode.dark;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    DummyData.isLightTheme = sharedPreferences.getBool("isLightTheme") ?? false;
    _themeMode =
        DummyData.isLightTheme == true ? ThemeMode.light : ThemeMode.dark;
    DummyData.accessToken = sharedPreferences.getString("accessToken");
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _setStatusBar();
    notifyListeners();
  }

  void _setStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness:
          _themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
    ));
  }

  ThemeMode get themeMode => _themeMode;
}
