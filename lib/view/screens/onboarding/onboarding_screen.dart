import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/src/screens.dart';

import '../../../model/local/onboarding_model.dart';

// ignore: must_be_immutable
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({
    super.key,
  });

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    ref.read(onboardingViewModel).getCryptPayBuyingRates();
    ref.read(onboardingViewModel).getCryptPaySellingRates();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    ThemeData theme = Theme.of(context);
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    var onboardingProvider = ref.watch(onboardingViewModel);
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 20.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Gap(0.h),
                Center(
                  child: Column(
                    children: [
                      ImageView.asset(
                        AppImages.tpayLogo,
                        width: 53.w,
                        height: 53.h,
                        color: AppColors.kPrimary1,
                      ),
                      Gap(10.h),
                      TextView(
                        text: "Cryptpay",
                        fontWeight: FontWeight.w700,
                        fontSize: 20.spMin,
                        color: AppColors.kPrimary1,
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 400.h,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: onboardingProvider.onboardingViewObjects.length,
                        onPageChanged: (page) => onboardingProvider.onPageChange(newPage: page),
                        itemBuilder: (context, index) {
                          OnboardingViewItemsModel onboardingViewObject =
                              onboardingProvider.onboardingViewObjects[index];
                          return Column(
                            children: [
                              Stack(
                                children: [
                                  Visibility(
                                    visible: index == 0,
                                    child: ImageView.asset(
                                      themeMode == ThemeMode.dark
                                          ? AppImages.tPayOnboardingImageDarkMode
                                          : AppImages.tPayOnboardingImageLightMode,
                                      width: 250.w,
                                      height: 250.h,
                                    ),
                                  ),
                                  Visibility(
                                    visible: index != 0,
                                    child: Column(
                                        children: List.generate(
                                            onboardingProvider
                                                .tPayCryptoRatesAtBuyingOrSelling(index)
                                                .length, (cryptoListRateIndex) {
                                      CryptoRatesModel cryptoCoins =
                                          onboardingProvider.tPayCryptoRatesAtBuyingOrSelling(
                                              index)[cryptoListRateIndex];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12.h,
                                          horizontal: 8.w,
                                        ),
                                        margin: EdgeInsets.only(bottom: 15.h),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16.r),
                                          color: themeMode == ThemeMode.dark
                                              ? AppColors.kOnyxBlack
                                              : AppColors.kLightSilver,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  onboardingProvider
                                                      .cryptoCoinImages[cryptoListRateIndex],
                                                  width: 32.w,
                                                  height: 32.h,
                                                ),
                                                Gap(3.w),
                                                TextView(
                                                  text: cryptoCoins.crypto ?? "Error",
                                                  textStyle: theme.textTheme.titleMedium,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                TextView(
                                                  text: "${cryptoCoins.rate}/$dollarSign",
                                                  textStyle: theme.textTheme.titleMedium,
                                                ),
                                                Gap(10.w),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 20.spMin,
                                                  color: themeMode == ThemeMode.light
                                                      ? AppColors.kGrey900
                                                      : AppColors.kWhite,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    })),
                                  ),
                                ],
                              ),
                              Gap(15.h),
                              TextView(
                                text: onboardingViewObject.title,
                                textStyle: theme.textTheme.titleLarge!.copyWith(fontSize: 24.spMin),
                              ),
                              Visibility(
                                visible: onboardingViewObject.description != null,
                                child: Column(
                                  children: [
                                    Gap(10.h),
                                    TextView(
                                      text: onboardingViewObject.description ?? "Error",
                                      maxLines: 2,
                                      fontSize: 14.spMin,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 57.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          3,
                          (index) => AnimatedContainer(
                            curve: Curves.easeIn,
                            width: onboardingProvider.currentPage == index ? 27.w : 7.w,
                            height: 7.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: onboardingProvider.currentPage == index
                                  ? AppColors.kPrimary1
                                  : themeMode == ThemeMode.light
                                      ? AppColors.kGrey300
                                      : AppColors.kGrey700,
                            ),
                            duration: const Duration(milliseconds: 150),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const OnBoardingBottomActions(),
              ],
            ),
          ),
        ));
  }
}

class OnBoardingBottomActions extends ConsumerWidget {
  const OnBoardingBottomActions({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultButtonMain(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          text: login,
          textColor: themeMode == ThemeMode.dark ? AppColors.kWhite : AppColors.kPrimary1,
          borderColor: themeMode == ThemeMode.dark ? AppColors.kWhite : AppColors.kPrimary1,
          onPressed: () {
            navigatePush(context, const SignInScreen());
          },
        ),
        Gap(10.w),
        DefaultButtonMain(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          color: AppColors.kPrimary1,
          text: signUp,
          onPressed: () {
            navigatePush(context, const CreateAccountScreen());
          },
        ),
      ],
    );
  }
}
