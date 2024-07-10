
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/repository.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/screens/onboarding/onboarding_screen.dart';

final dashboardViewModel =
    ChangeNotifierProvider((ref) => DashboardViewModel());

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


  Future<void> initDashboard(int setIndex) async {
    if (DummyData.firstTimeOnApp == true || DummyData.firstTimeOnApp == null || DummyData.accessToken == null) {
      _currentIndex = 1;
    } else {
      _currentIndex = setIndex;
    }
    // notifyListeners();
  }

  Future<void> setBottomBarItem(BuildContext context, int selectedPageIndex) async {
    _currentIndex = selectedPageIndex;
    notifyListeners();
  }

  String getTitle(num? role) {
    switch (_currentIndex) {
      case 1:
        return marketPlace;
      case 2:
        return role == 2 ? "Properties" : listings;
      case 3:
        return wallet;
      case 4:
        return more;
      default:
        return 'Hello, ${UtilFunctions.capitalizeAllWord(DummyData.firstName.toString())}';
    }
  }

}
