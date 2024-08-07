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

  List<String> modes = ["Light Mode", "Dark Mode", "System Mode"];

  ThemeMode _themeMode = ThemeMode.light;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // DummyData.isDarkTheme = sharedPreferences.getBool("isDarkTheme") ?? false;
    DummyData.appTheme = sharedPreferences.getString("AppTheme");
    _themeMode = DummyData.appTheme!.isEmpty || DummyData.appTheme!.toString() == 'System Mode'?
    ThemeMode.system : DummyData.appTheme!.toString() == 'Dark Mode'?  ThemeMode.dark : ThemeMode.light;

    setThemeMode( ThemeMode.system == ThemeMode.dark ?  ThemeMode.dark :  ThemeMode.light);
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
      statusBarBrightness:
      _themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
    ));
  }

  ThemeMode get themeMode => _themeMode;
}
