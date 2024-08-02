import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:rebirth/rebirth.dart';
import 'package:tampay/model/local/dummy_data.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampay/view/screens/auth/signin_forgot_password/welcome_back_screen.dart';

import '../model/local/onboarding_model.dart';

final onboardingViewModel = ChangeNotifierProvider((ref) => OnboardingViewModel());

class OnboardingViewModel extends ChangeNotifier {
  late SharedPreferences sharedPreferences;

  int _currentPage = 0;
  int get currentPage => _currentPage;
  List<CryptoRatesModel> get cryptPayBuyingRates => _cryptPayBuyingRates;
  List<CryptoRatesModel> get cryptPaySellingRates => _cryptPaySellingRates;
  List<CryptoRatesModel> _cryptPayBuyingRates = [];
  List<CryptoRatesModel> _cryptPaySellingRates = [];
  final List<String> _cryptoCoinImages = [
    AppImages.btcLogo,
    AppImages.ethLogo,
    AppImages.usdtLogo,
    AppImages.solanaLogo,
  ];
  List<String> get cryptoCoinImages => _cryptoCoinImages;
  void onPageChange({required int newPage}) {
    _currentPage = newPage;
    notifyListeners();
  }

  Future<void> getCryptPayBuyingRates() async {
    var cryptoJson = await rootBundle.loadString("assets/json/crypto_buying_rate.json");
    List<dynamic> decodedResponse = jsonDecode(cryptoJson);
    _cryptPayBuyingRates = decodedResponse
        .map(
          (e) => CryptoRatesModel.fromJson(e),
        )
        .toList();
    debugPrint('$_cryptPayBuyingRates');
  }

  List<CryptoRatesModel> tPayCryptoRatesAtBuyingOrSelling(int index) {
    switch (index) {
      case 1:
        return _cryptPayBuyingRates;
      case 2:
        return _cryptPaySellingRates;
      default:
        return [];
    }
  }

  Future<void> getCryptPaySellingRates() async {
    var cryptoJson = await rootBundle.loadString("assets/json/crypto_selling_rate.json");
    List<dynamic> decodedResponse = jsonDecode(cryptoJson);
    _cryptPaySellingRates = decodedResponse
        .map(
          (e) => CryptoRatesModel.fromJson(e),
        )
        .toList();
    debugPrint('$_cryptPaySellingRates');
  }

  final List<OnboardingViewItemsModel> _onboardingViewObjects = [
    OnboardingViewItemsModel(title: "Ultimate Cash in,\nCash Out App"),
    OnboardingViewItemsModel(
      title: "Buying Rates",
      description: "Stay updated with the most current rates "
          "for purchasing your preferred cryptocurrencies.",
    ),
    OnboardingViewItemsModel(
      title: "Selling Rates",
      description: "Stay updated with the most current rates "
          "for selling your preferred cryptocurrencies.",
    ),
  ];

  List<OnboardingViewItemsModel> get onboardingViewObjects => _onboardingViewObjects;
  checkUser(context) {
    initData().then((onValue) async {
      sharedPreferences = await SharedPreferences.getInstance();
      DummyData.isDarkTheme = sharedPreferences.getBool("isDarkTheme") ?? false;
      DummyData.firstTimeOnApp = sharedPreferences.getBool("firstTimeOnApp");

      if (DummyData.firstTimeOnApp == true ||
          DummyData.firstTimeOnApp == null ||
          DummyData.accessToken == null) {
        navigateReplace(context, const OnboardingScreen());
      } else {
        logger.i("Check User");
        //  DummyData.localUserID = sharedPreferences.getString("UserID");`
        DummyData.emailAddress = sharedPreferences.getString("Email");
        DummyData.password = sharedPreferences.getString("Password");
        DummyData.accessToken = sharedPreferences.getString("accessToken");

        logger.i(DummyData.emailAddress);
        logger.i(DummyData.accessToken);

        bool hasExpired = Jwt.isExpired(DummyData.accessToken.toString());
        logger.w(hasExpired);

        if (!hasExpired) {
          await ProfileViewModel().loadData(context).then((value) async {
            if (value != null) {
              DummyData.firstName = value.firstName.toString();
              DummyData.lastName = value.lastName.toString();
              // await navigateReplace(context, const DashBoardScreen());
            } else {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('Email');
              await prefs.remove('Password');
              await prefs.remove('accessToken');
              DummyData.firstName = '';
              DummyData.lastName = '';
              await Future.delayed(const Duration(seconds: 2));
              WidgetRebirth.createRebirth(context: context);
              // navigateReplace(context, const DashBoardScreen(setIndex: 1,));
            }
          });
        } else {
          if (DummyData.emailAddress != null && DummyData.password != null) {
            logger.i(DummyData.emailAddress);
            logger.i(DummyData.password);
            navigateReplace(context, const WelcomeBackScreen());
            // AuthViewModel().userAutoLogin(context,
            //     email: DummyData.emailAddress.toString(), password: DummyData.password.toString());
          } else {
            navigateReplace(context, const OnboardingScreen());
            logger.e("error");
          }
        }
      }
    });
  }

  Future<void> initData() async {
    await Future<void>.delayed(const Duration(seconds: 3));
  }
}
