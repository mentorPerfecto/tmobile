import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/src/screens.dart';

// ignore: must_be_immutable
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({
    super.key,
  });

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {

  @override
  Widget build(
    BuildContext context,
  ) {
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
                Gap(50.h),
                SizedBox(
                  width: 300.w,
                  height: 500.h,
                  child:    OnBoardingDisplay(
                    displayImage: Image.asset(
                      AppImages.onboardingUltimateCashBackgroundImage,
                      height: 200.h,
                      width: 200.w,
                    ),
                    displayText: "Ultimate Cash in, \nCash out App",
                  ),
                ),
                OnBoardingBottomActions(),
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
      mainAxisAlignment: MainAxisAlignment.center,
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

class OnBoardingBottomActions extends StatelessWidget {
  const OnBoardingBottomActions({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
