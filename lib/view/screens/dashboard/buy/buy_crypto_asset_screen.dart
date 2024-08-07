import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import '../../../../src/components.dart';

class BuyCryptoAssetScreen extends ConsumerStatefulWidget {
  const BuyCryptoAssetScreen({super.key});

  @override
  ConsumerState<BuyCryptoAssetScreen> createState() => _BuyCryptoAssetScreenState();
}

class _BuyCryptoAssetScreenState extends ConsumerState<BuyCryptoAssetScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(buyViewModel).getCryptoCoins();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    var buySectionProvider = ref.watch(buyViewModel);
    var dashboardProvider = ref.watch(dashboardViewModel);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
        bottomVisible: true,
        bottomText: "Buy ${DummyData.cryptoAbbreviation}",
      ),
      body: XResponsiveWrap.mobile(
        onRefresh: () => buySectionProvider.getCryptoCoins(),
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WalletAddress(theme: theme, themeMode: themeMode),
                Gap(25.h),
                const AmountYouWillPayInNaira(),
                Gap(20.h),
                Align(
                  alignment: Alignment.center,
                  child: ImageView.asset(
                    AppImages.squareArrowIcon,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
                Gap(20.h),
                CustomTextField(
                  fieldLabel: "You'll receive (${DummyData.cryptoAbbreviation})",
                  prefixIcon: ImageView.asset(
                    AppImages.tronCircleIcon,
                    width: 15.w,
                    height: 15.h,
                    scale: 4,
                  ),
                  showSuffixText: true,
                  suffixText: "0.000000000",
                ),
                Gap(80.h),
                DefaultButtonMain(
                  text: dashboardProvider.buyCryptoAssetButtonState.text,
                  buttonState: dashboardProvider.buyCryptoAssetButtonState.buttonState,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AmountYouWillPayInNaira extends StatelessWidget {
  const AmountYouWillPayInNaira({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          fieldLabel: "You'll pay (NGN)",
          prefixIcon: ImageView.asset(
            AppImages.countryIcon,
            width: 15.w,
            height: 15.h,
            scale: 4,
          ),
          showSuffixText: true,
          suffixText: "NGN 0",
        ),
        Gap(5.h),
        TextView(
          text: "Minimum: NGN 1756 = 1 ${DummyData.cryptoAbbreviation}",
          fontSize: 14.spMin,
          color: AppColors.kStormySky,
        )
      ],
    );
  }
}

class WalletAddress extends StatelessWidget {
  const WalletAddress({
    super.key,
    required this.theme,
    required this.themeMode,
  });

  final ThemeData theme;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          fieldLabelActionWidget: Row(
            children: [
              ImageView.asset(
                AppImages.notebookIcon,
                width: 20.w,
                height: 20.h,
                color: theme.colorScheme.primary,
              ),
              Gap(25.w),
              ImageView.asset(
                AppImages.scanIcon,
                width: 20.w,
                height: 20.h,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
          fieldLabel: "Address",
          hint: "Enter Wallet Address",
        ),
        Gap(10.h),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: themeMode == ThemeMode.light ? AppColors.kLightSilver : AppColors.kOnyxBlack,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageView.asset(
                AppImages.infoIcon,
                width: 20.w,
                height: 20.h,
                color: themeMode == ThemeMode.light ? AppColors.kGrey400 : AppColors.kGrey500,
              ),
              Gap(5.w),
              Text.rich(
                maxLines: 2,
                TextSpan(
                  text: "Please ensure that the receiving address supports the\n",
                  children: [
                    TextSpan(
                      text: DummyData.networkType,
                      style: TextStyle(
                        fontSize: 10.spMin,
                        fontWeight: FontWeight.w400,
                        color: AppColors.kGrey900,
                      ),
                    ),
                    TextSpan(
                      text: " network",
                      style: TextStyle(
                        fontSize: 10.spMin,
                        fontWeight: FontWeight.w400,
                        color: AppColors.kGrey500,
                      ),
                    )
                  ],
                ),
                style: TextStyle(
                  fontSize: 10.spMin,
                  fontWeight: FontWeight.w400,
                  color: AppColors.kGrey500,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CryptoCoinView extends StatelessWidget {
  const CryptoCoinView(
      {super.key,
      required this.cryptoSymbol,
      required this.cryptoName,
      required this.cryptoAcronym,
      required this.aCryptoCoin,
      required this.onPressed});

  final String cryptoSymbol;
  final String cryptoName;
  final String cryptoAcronym;
  final CryptoCoinResponse aCryptoCoin;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 25.h,
                horizontal: 15.w,
              ),
              child: GestureDetector(
                onTap: onPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 112.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(cryptoSymbol),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                text: cryptoName,
                                fontSize: 14.spMin,
                              ),
                              Gap(3.h),
                              TextView(
                                text: cryptoAcronym,
                                color: AppColors.kCardText,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    TextView(
                      text:
                          "₦${UtilFunctions.formatAmount(aCryptoCoin.rate?.toDouble() ?? 0.0)}/$dollarSign",
                      fontSize: 14.spMin,
                    )
                  ],
                ),
              ),
            ),
          ),
          const TampayDivider(),
        ],
      ),
    );
  }
}
