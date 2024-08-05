import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';

final walletViewModel = ChangeNotifierProvider((ref) => WalletViewModel());

class WalletViewModel extends ChangeNotifier {
  bool _showWalletBal = false;


  bool get showWalletBal => _showWalletBal;

  void toggleWalletBal() {
    _showWalletBal = !_showWalletBal;
    notifyListeners();
  }


}
