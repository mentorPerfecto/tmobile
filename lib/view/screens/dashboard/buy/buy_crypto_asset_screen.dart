import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/screens/dashboard/buy/crypto_asset_final_purchase_screen.dart';
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 20.h),
            child: Column(
              children: [
                SingleChildScrollView(
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
                        controller: dashboardProvider.cryptoAssetController,
                        onChanged: (p0) => dashboardProvider.setBuyCryptoAssetButtonState(),
                        trailing: TextView(
                          text: "0.000000000",
                          fontSize: 14.spMin,
                          color: AppColors.kGrey500,
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.end,
                        fieldLabel: "You'll receive (${DummyData.cryptoAbbreviation})",
                        prefixIcon: ImageView.asset(
                          AppImages.tronCircleIcon,
                          width: 15.w,
                          height: 15.h,
                          scale: 4,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(100.h),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: DefaultButtonMain(
                    color: AppColors.kPrimary1,
                    text: dashboardProvider.buyCryptoAssetButtonState.text,
                    buttonState: dashboardProvider.buyCryptoAssetButtonState.buttonState,
                    onPressed: () {
                      ///`validate wallet address text field`
                      navigatePush(context, const CryptoAssetFinalPurchaseScreen());
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AmountYouWillPayInNaira extends ConsumerWidget {
  const AmountYouWillPayInNaira({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dashProvider = ref.watch(dashboardViewModel);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: dashProvider.amountToPayInNairaController,
          onChanged: (p0) => dashProvider.setBuyCryptoAssetButtonState(),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.end,
          fieldLabel: "You'll pay (NGN)",
          prefixIcon: ImageView.asset(
            AppImages.countryIcon,
            width: 15.w,
            height: 15.h,
            scale: 4,
          ),
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

class WalletAddress extends ConsumerWidget {
  const WalletAddress({
    super.key,
    required this.theme,
    required this.themeMode,
  });

  final ThemeData theme;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dashProvider = ref.watch(dashboardViewModel);
    return Column(
      children: [
        Form(
          key: dashProvider.walletAddressFormKey,
          child: CustomTextField(
            controller: dashProvider.walletAddressController,
            onChanged: (p0) => dashProvider.setBuyCryptoAssetButtonState(),
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
