import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/model/local/button_state.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';

final dashboardViewModel = ChangeNotifierProvider((ref) => DashboardViewModel());

class DashboardViewModel extends ChangeNotifier {
  GlobalKey walletAddressFormKey = GlobalKey<FormState>();
  int? _currentIndex = 0;
  int? _exchangeCurrentIndex = 0;
  final TextEditingController _walletAdressController = TextEditingController();
  final TextEditingController _amountToPayInNairaController = TextEditingController();
  final TextEditingController _cryptoAssetController = TextEditingController();
  CustomButtonState _buyCryptoAssetButtonState =
      CustomButtonState(
    buttonState: ButtonState.disabled,
    text: next,
  );
  int get currentIndex => _currentIndex!;
  int get exchangeCurrentIndex => _exchangeCurrentIndex!;
  TextEditingController get walletAddressController => _walletAdressController;
  TextEditingController get amountToPayInNairaController => _amountToPayInNairaController;
  TextEditingController get cryptoAssetController => _cryptoAssetController;
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
setBuyCryptoAssetButtonState() {
    if (_walletAdressController.text.isNotEmpty &&
        _amountToPayInNairaController.text.isNotEmpty &&
        _cryptoAssetController.text.isNotEmpty) {
      _buyCryptoAssetButtonState = CustomButtonState(
        buttonState: ButtonState.idle,
        text: next,
      );
    } else {
      _buyCryptoAssetButtonState = CustomButtonState(
        buttonState: ButtonState.disabled,
        text: next,
      );
    }
    notifyListeners();
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

  Color transactionStatusColor(String transactionStatus) {
    switch (transactionStatus) {
      case "Pending":
        return AppColors.kHarvestGold;
      case "Completed":
        return AppColors.kScreamingGreen;
      case "Failed":
        return AppColors.kError300;

      default:
        return AppColors.kWhite;
    }
  }
}
