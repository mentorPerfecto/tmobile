import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/src/screens.dart';

// ignore: must_be_immutable
class OnboardingScreen extends ConsumerStatefulWidget {
  OnboardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;
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
       
        decoration: BoxDecoration(
          color: AppColors.kTransparent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.kHarvestGold.withOpacity(0.5),
              spreadRadius: 100,
              blurRadius: 200,
              
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
       
        decoration: BoxDecoration(
          color: AppColors.kTransparent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: AppColors.kPrimary1.withOpacity(0.5),
              spreadRadius: 100,
              blurRadius: 200,
            
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
                SizedBox(
                  width: 300.w,
                  height: 300.h,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _controller,
                    onPageChanged: (page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: onboardingDisplayList.length,
                    itemBuilder: (context, index) {
                      return onboardingDisplayList[_currentPage];
                    },
                  ),
                ),
                Gap(5.h),
                OnBoardingButtomActions(
                  currentPage: _currentPage,
                ),
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
    required this.currentPage
  });
  final int currentPage;
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
                      color: currentPage == index ? AppColors.kScreaminGreen : AppColors.kWhite,
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
