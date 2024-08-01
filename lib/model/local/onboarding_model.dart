import 'package:flutter/material.dart';

class OnboardingViewModel {
  final String title;
  final String? description;
  OnboardingViewModel({required this.title, this.description});
}

class CryptoRatesModel {
  String? crypto;
  int? rate;

  CryptoRatesModel({
    this.crypto,
    this.rate,
  });
  factory CryptoRatesModel.fromJson(Map<String, dynamic> json) {
    return CryptoRatesModel(
      crypto: json["id"] as String?,
      rate: json["rate"] as int?,
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
