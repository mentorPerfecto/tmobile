import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';

import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';

class BuyRatesScreen extends ConsumerWidget {
  const BuyRatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    List<CryptoRatesModel> _coins = [
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              bottom: 15.h,
              top: 40.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(),
                Gap(200.h),
                DefaultButtonMain(
                  color: AppColors.kPrimary1,
                  text: startTrading,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
