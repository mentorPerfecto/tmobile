import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsViewModel = ChangeNotifierProvider((ref) => SettingsViewModel());

class SettingsViewModel extends ChangeNotifier {
  bool _sendPushNotification = false;
  bool _sendEmailNotification = false;

  bool get sendEmailNotification => _sendEmailNotification;
  bool get sendPromotionsEmail => _sendPromotionsEmail;
  bool get sendPushNotification => _sendPushNotification;
  bool _sendPromotionsEmail = false;

  String selectedCurrency ='';
  String selectedTheme='';





  void togglePromotionsEmail(bool val) {
    _sendPromotionsEmail = val ;
    notifyListeners();
  }

  Future<void> loadData() async {

    notifyListeners();
  }


  void togglePushNotification (bool val) {
    _sendPushNotification = val ;
    notifyListeners();
  }


  void toggleEmailNotification(bool val) {
    _sendEmailNotification = val ;
    notifyListeners();
  }


}