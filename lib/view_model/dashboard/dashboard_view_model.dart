import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';

final dashboardViewModel = ChangeNotifierProvider((ref) => DashboardViewModel());

class DashboardViewModel extends ChangeNotifier {
  int? _currentIndex = 0;
  String? _landlordProperty;

  String? get landlordProperty => _landlordProperty;
  final String _token = '';
  String get token => _token;

  int get currentIndex => _currentIndex!;
  String? country, state, locality, subLocality;

  void selectProperty(String? property) {
    _landlordProperty = property;
    notifyListeners();
  }

  void setPageIndexToHome(BuildContext context) {
    _currentIndex = 0;
    notifyListeners();
    navigatePush(context, const DashBoardScreen());
  }

  setPageIndex({int? selectedPageIndex}) {
    _currentIndex = selectedPageIndex ?? 0;
    notifyListeners();
    // getDeviceLocation();
  }

  Future<void> setBottomBarItem(BuildContext context, int selectedPageIndex) async {
    _currentIndex = selectedPageIndex;
    notifyListeners();
  }

  Future<void> copyToClipboard(String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    showToast(msg: "Copied $value to clipboard", isError: false);
  }


  AnimationController? animationController;
  Animation<double>? animation;

}
