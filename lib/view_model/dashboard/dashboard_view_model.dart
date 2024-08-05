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
  int? _exchangeCurrentIndex = 0;

  int get currentIndex => _currentIndex!;
  int get exchangeCurrentIndex => _exchangeCurrentIndex!;

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

  setExchangePageIndex({int? selectedPageIndex}) {
    _exchangeCurrentIndex = selectedPageIndex ?? 0;
    notifyListeners();
    // getDeviceLocation();
  }


  Future<void> copyToClipboard(String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    showToast(msg: "Copied $value to clipboard", isError: false);
  }

}
