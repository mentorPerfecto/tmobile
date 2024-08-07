import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/model/local/button_state.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';

final dashboardViewModel = ChangeNotifierProvider((ref) => DashboardViewModel());

class DashboardViewModel extends ChangeNotifier {
  int? _currentIndex = 0;
  int? _exchangeCurrentIndex = 0;
  CustomButtonState _buyCryptoAssetButtonState =
      CustomButtonState(buttonState: ButtonState.disabled, text: next);
  int get currentIndex => _currentIndex!;
  int get exchangeCurrentIndex => _exchangeCurrentIndex!;
  CustomButtonState get buyCryptoAssetButtonState => _buyCryptoAssetButtonState;
  String? _cryptoAcronym;
  final List<String> _tPayCryptoAssets = ["BTC", "USDT", "ETH", "SOL"];
  String? get cryptoAcronym => _cryptoAcronym;
  List<String> get tPayCryptoAssets => _tPayCryptoAssets;

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

  getCrptoAcronymAndName({String? acronym, String? name}) {
    DummyData.cryptoAbbreviation = acronym ?? "Error";
    _cryptoAcronym = acronym;
    DummyData.crypto = name ?? "ERROR";
    notifyListeners();
  }

  selectACyptoAsset({String? cryptoAcronym, String? name}) {
    _cryptoAcronym = cryptoAcronym;
    DummyData.cryptoAbbreviation = cryptoAcronym ?? "Error";
    notifyListeners();
  }

  setNetworkType(String? networkType) {
    DummyData.networkType = networkType;
    notifyListeners();
  }

  Future<void> copyToClipboard(
    String value,
  ) async {
    await Clipboard.setData(ClipboardData(text: value));
  }
}
