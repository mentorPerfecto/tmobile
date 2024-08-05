import 'package:flutter/material.dart';

class OnboardingViewItemsModel {
  final String title;
  final String? description;
  OnboardingViewItemsModel({required this.title, this.description});
}

class CryptoRatesModel {
  String? crypto;
  int? rate;
  String? cryptoAncronym;

  CryptoRatesModel({
    this.crypto,
    this.rate,
    this.cryptoAncronym,
  });
  factory CryptoRatesModel.fromJson(Map<String, dynamic> json) {
    return CryptoRatesModel(
      crypto: json["id"] as String?,
      rate: json["rate"] as int?,
      cryptoAncronym: json["short_form"] as String?,
    );
  }
}

// List<OnBoardingItemModel> onboardingItemModel = [
//   OnBoardingItemModel(
//     title: "Predict Matches",
//     image: AppImages.onboardingOne, subTitle: 'Guess the outcomes of matches and climb the leaderbaoards',
//   ),
//   OnBoardingItemModel(
//     title: "Join Competitions",
//     image: AppImages.onboardingOne, subTitle: 'Engage in global contests or create your custom leagues',
//   ),
//   OnBoardingItemModel(
//     title: "Win Rewards",
//     image: AppImages.onboardingTwo, subTitle: 'Compete for prizes in paid leagues and claim your victory',
//   ),

// ];
