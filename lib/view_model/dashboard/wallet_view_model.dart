import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final walletViewModel = ChangeNotifierProvider((ref) => WalletViewModel());

class WalletViewModel extends ChangeNotifier {
  bool _showWalletBal = false;


  bool get showWalletBal => _showWalletBal;

  void toggleWalletBal() {
    _showWalletBal = !_showWalletBal;
    notifyListeners();
  }


}
