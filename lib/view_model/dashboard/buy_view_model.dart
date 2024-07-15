import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/config/app_strings.dart';
import 'package:tampay/model/local/button_state.dart';
import 'package:tampay/model/response/local_response/tpay_coin_response/crypto_coin_response.dart';
import 'package:tampay/src/utils.dart';

final buyViewModel = ChangeNotifierProvider((ref) => BuyViewModel());

class BuyViewModel extends ChangeNotifier {
  List<CryptoCoinResponse> _cryptoList = [];
  FocusNode paymentNode = FocusNode();
  FocusNode receipientNode = FocusNode();
  List<CryptoCoinResponse> get cryptoList => _cryptoList;
  CustomButtonState _enterAmountButtonState = CustomButtonState(
    buttonState: ButtonState.disabled,
    text: continueText,
  );
  TextEditingController _paymentController = TextEditingController();
  TextEditingController _receipientController = TextEditingController();
  CustomButtonState get enterAmountButtonState => _enterAmountButtonState;
  TextEditingController get paymentController => _paymentController;
  TextEditingController get receipientController => _receipientController;
  void updateEnterAmountButtonState() {
    if (_paymentController.text.isNotEmpty & _receipientController.text.isNotEmpty) {
      _enterAmountButtonState = CustomButtonState(
        buttonState: ButtonState.idle,
        text: continueText,
      );
    } else {
      _enterAmountButtonState = CustomButtonState(
        buttonState: ButtonState.disabled,
        text: continueText,
      );
    }
    notifyListeners();
  }

  Future<void> getCryptoCoins() async {
    var cryptoJson = await rootBundle.loadString("assets/json/coin_list.json");
    List<dynamic> decodedResponse = jsonDecode(cryptoJson);
    _cryptoList = decodedResponse.map((e) => CryptoCoinResponse.fromJson(e)).toList();
    debugPrint('$_cryptoList');
  }
}
