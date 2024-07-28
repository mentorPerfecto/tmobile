import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';

import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/screens/onboarding/onboarding_screen.dart';

class BuyRatesScreen extends ConsumerWidget {
  const BuyRatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    final List<CryptoRatesModel> coins = [
      CryptoRatesModel(
        crypto: btc,
        cryptoImage: AppImages.btcLogo,
        rate: 1780,
      ),
      CryptoRatesModel(
        crypto: eth,
        cryptoImage: AppImages.ethLogo,
        rate: 1850,
      ),
      CryptoRatesModel(
        crypto: usdt,
        cryptoImage: AppImages.usdtLogo,
        rate: 1650,
      ),
      CryptoRatesModel(
        crypto: sol,
        cryptoImage: AppImages.solanaLogo,
        rate: 1650,
      ),
    ];
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 15.w,
            right: 15.w,
            bottom: 25.h,
            top: 40.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: buyRates,
                    fontSize: 20.spMin,
                    fontWeight: FontWeight.w600,
                  ),
                  Gap(20.h),
                  ...coins.map(
                    (cryptoCoins) => Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 8.w,
                      ),
                      margin: EdgeInsets.only(bottom: 15.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColors.kOnyxBlack,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                cryptoCoins.cryptoImage,
                                width: 32.w,
                                height: 32.h,
                              ),
                              Gap(3.w),
                              TextView(
                                text: cryptoCoins.crypto,
                                color: AppColors.kGrey400,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              TextView(
                                text: "${cryptoCoins.rate}/$dollarSign",
                                color: AppColors.kGrey400,
                              ),
                              Gap(10.w),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20.spMin,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              DefaultButtonMain(
                color: AppColors.kPrimary1,
                text: startTrading,
                onPressed: () => navigatePush(context, const OnboardingScreen()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
