import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/src/screens.dart';

// ignore: must_be_immutable
class OnboardingScreen extends ConsumerWidget {
 
  OnboardingScreen({
    Key? key,
  }) : super(key: key);

  final PageController _controller = PageController();
  List<OnBoardingDisplay> onboardingDisplayList = [
    OnBoardingDisplay(
      displayImage: Stack(
        children: [
          Image.asset(
            AppImages.onboardingUltimateCashBackgroundImage,
            height: 200.h,
            width: 200.w,
          ),
          Positioned(
            left: 70,
            bottom: 80,
            child: Image.asset(
              AppImages.tPayLogo,
              width: 55.w,
              height: 55.h,
            ),
          )
        ],
      ),
      displayText: "Ultimate Cash in, \nCash out App",
    ),
    OnBoardingDisplay(
      displayImage: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.kTransparent,
          boxShadow: [
            BoxShadow(
              color: AppColors.kHarvestGold.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // Shadow offset (x, y)
            ),
          ],
        ),
        child: Image.asset(
          AppImages.onboardingFasterTransactionLogo,
          width: 105.w,
          height: 105.h,
        ),
      ),
      displayText: "Convenient &,\nFaster Transactions",
    ),
    OnBoardingDisplay(
      displayImage: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.kTransparent,
          boxShadow: [
            BoxShadow(
              color: AppColors.kPrimary1.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // Shadow offset (x, y)
            ),
          ],
        ),
        child: Image.asset(
          AppImages.onboardingCryptoSwapLogo,
          width: 105.w,
          height: 105.h,
        ),
      ),
      displayText: "Easy crypto swaps",
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeViewModel).themeMode;
    ThemeData theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 20.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _controller,
                  itemCount: onboardingDisplayList.length,
                  itemBuilder: (context, index) {
                    return onboardingDisplayList[index];
                  },
                ),
                Gap(40.h),
                OnBoardingButtomActions(),
              ],
            ),
          ),
        ));
  }
}

class OnBoardingDisplay extends StatelessWidget {
  const OnBoardingDisplay({
    super.key,
    required this.displayImage,
    required this.displayText,
  });
  final Widget displayImage;
  final String displayText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        displayImage,
        Gap(12.h),
        TextView(
          textAlign: TextAlign.center,
          text: displayText,
          maxLines: 2,
          textStyle: TextStyle(
            fontFamily: soraFont,
            fontSize: 24.spMin,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class OnBoardingButtomActions extends StatelessWidget {
  const OnBoardingButtomActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                3,
                (index) => Container(
                      padding: EdgeInsets.only(right: 2.w),
                      height: 4.h,
                      width: 40.w,
                      color: index == 1 ? AppColors.kWhite : Colors.green,
                    )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultButtonMain(
                padding: EdgeInsets.symmetric(horizontal: 26.w),
                text: login,
                borderColor: AppColors.kPrimary1,
                textColor: AppColors.kPrimary1,
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
          ),
        ],
      ),
    );
  }
}
