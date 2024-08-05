import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/model/local/dummy_data.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/view/components/tpay_default_pop_up.dart';
import '../../../../src/utils.dart';

class BuyCoinScreen extends ConsumerStatefulWidget {
  BuyCoinScreen({Key? key, required this.cryptoAcronym}) : super(key: key);
  final String cryptoAcronym;
  @override
  ConsumerState<BuyCoinScreen> createState() => _BuyCoinScreenState();
}

class _BuyCoinScreenState extends ConsumerState<BuyCoinScreen> {
  int _minutesRemaining = 9;
  int _secondsRemaining = 59;
  late Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        logger.e("seconds:$_secondsRemaining");
        logger.e("minutes:$_minutesRemaining");
        if (_minutesRemaining & _secondsRemaining == 0) {
          timer.cancel();
        } else {
          if (_secondsRemaining > 0) {
            setState(() {
              _secondsRemaining--;
            });
            logger.e("seconds remaining:$_secondsRemaining");
          } else if (_secondsRemaining == 0) {
            setState(() {
              _minutesRemaining -= 1;
              _secondsRemaining == 59;
            });
            logger.e("seconds:$_secondsRemaining");
            logger.e("minutes Remaining:$_minutesRemaining");
          }
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var buySectionProvider = ref.watch(buyViewModel);
    var dashViewModel = ref.watch(dashboardViewModel);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
    
        text: buyCoin,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BuyCoinScreenItems(
                screenItem: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 25.spMin,
                    horizontal: 15.spMin,
                  ),
                  child: TextView(
                    text: "${DummyData.coinValue} ${widget.cryptoAcronym}",
                    fontSize: 18.spMin,
                  ),
                ),
              ),
              BuyCoinScreenItems(
                screenItem: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 25.spMin,
                    horizontal: 15.spMin,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextView(
                        text: timeLeftToTransfer,
                        color: AppColors.kGrey300,
                      ),
                      SizedBox(
                        width: 70.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: AppColors.kSunFlower,
                              ),
                              child: TextView(
                                text: "0$_minutesRemaining",
                                fontSize: 10.spMin,
                              ),
                            ),
                            Gap(2.h),
                            TextView(
                              text: ":",
                              fontSize: 10.spMin,
                            ),
                            Gap(2.h),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: AppColors.kSunFlower,
                              ),
                              child: TextView(
                                text: _secondsRemaining > 9
                                    ? "$_secondsRemaining"
                                    : "0$_secondsRemaining",
                                fontSize: 10.spMin,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              BuyCoinScreenItems(
                screenItem: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 25.spMin,
                    horizontal: 15.spMin,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextView(
                            text: statusText,
                            color: AppColors.kGrey300,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 2.h,
                              horizontal: 6.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: AppColors.kVeryLightYellow,
                            ),
                            child: TextView(
                              text: pendingPayment,
                              fontSize: 10.spMin,
                              color: AppColors.kSunFlower,
                            ),
                          ),
                        ],
                      ),
                      Gap(12.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextView(
                            text: reference,
                            color: AppColors.kGrey400,
                          ),
                          Row(
                            children: [
                              const TextView(
                                text: '256521T5841sgasga5514sjsg',
                                color: AppColors.kGrey400,
                              ),
                              Gap(5.w),
                              InkWell(
                                onTap: () {
                                  dashViewModel.copyToClipboard('256521T5841sgasga5514sjsg');
                                },
                                child: Image.asset(
                                  AppImages.copyLogo,
                                  width: 18.w,
                                  height: 18.h,
                                  color: AppColors.kPrimary1,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Gap(20.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 15.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: paymentDetails,
                      fontSize: 14.spMin,
                    ),
                    Gap(20.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextView(
                          text: bankName,
                          color: AppColors.kGrey400,
                        ),
                        Row(
                          children: [
                            const TextView(
                              text: 'Fidelity Bank',
                              color: AppColors.kGrey400,
                            ),
                            Gap(5.w),
                            InkWell(
                              onTap: () {
                                dashViewModel.copyToClipboard('Fidelity Bank');
                              },
                              child: Image.asset(
                                AppImages.copyLogo,
                                width: 18.w,
                                height: 18.h,
                                color: AppColors.kPrimary1,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Gap(20.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextView(
                          text: accountNumber,
                          color: AppColors.kGrey400,
                        ),
                        Row(
                          children: [
                            const TextView(
                              text: '0550241576',
                              color: AppColors.kGrey400,
                            ),
                            Gap(5.w),
                            InkWell(
                              onTap: () {
                                dashViewModel.copyToClipboard('0550241576');
                              },
                              child: Image.asset(
                                AppImages.copyLogo,
                                width: 18.w,
                                height: 18.h,
                                color: AppColors.kPrimary1,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Gap(20.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextView(
                          text: nameOfMerchant,
                          color: AppColors.kGrey400,
                        ),
                        Row(
                          children: [
                            const TextView(
                              text: 'Pius Moses',
                              color: AppColors.kGrey400,
                            ),
                            Gap(5.w),
                            InkWell(
                              onTap: () {
                                dashViewModel.copyToClipboard('Pius Moses');
                              },
                              child: Image.asset(
                                AppImages.copyLogo,
                                width: 18.w,
                                height: 18.h,
                                color: AppColors.kPrimary1,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Gap(20.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 12.w,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.kSunFlower),
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.kFloralWhite,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: "Note:",
                            fontSize: 14.spMin,
                            color: AppColors.kMidnight950,
                          ),
                          Gap(15.h),
                          Text.rich(
                            TextSpan(
                              text: "1. ",
                              style: TextStyle(
                                fontSize: 10.spMin,
                                fontWeight: FontWeight.w400,
                                color: AppColors.kMidnight950,
                                fontFamily: soraFont,
                              ),
                              children: [
                                TextSpan(
                                  text: "Do not reference ",
                                  style: TextStyle(
                                    fontSize: 10.spMin,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.kMidnight950,
                                    fontFamily: soraFont,
                                  ),
                                ),
                                TextSpan(
                                  text: '"Crypto"',
                                  style: TextStyle(
                                    fontSize: 10.spMin,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kMidnight950,
                                    fontFamily: soraFont,
                                  ),
                                ),
                                TextSpan(
                                  text: 'in your transfer description',
                                  style: TextStyle(
                                    fontSize: 10.spMin,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.kMidnight950,
                                    fontFamily: soraFont,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(4.h),
                          TextView(
                            text: "2. $makeSureYouSentExactAmount",
                            fontSize: 10.spMin,
                            color: AppColors.kMidnight950,
                          ),
                          Gap(4.h),
                          TextView(
                            text: "3. $recheckTransactionDetailsBeforeConfirming",
                            fontSize: 10.spMin,
                            color: AppColors.kMidnight950,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Gap(35.h),
              const BuyCoinScreenBottomActions()
            ],
          ),
        ),
      ),
    );
  }
}

class BuyCoinScreenBottomActions extends ConsumerWidget {
  const BuyCoinScreenBottomActions({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dashboardProvider = ref.watch(dashboardViewModel);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
      child: Row(
        children: [
          DefaultButtonMain(
            padding: EdgeInsets.symmetric(horizontal: 34.w),
            text: cancelTrade,
            borderColor: AppColors.kPrimary1,
            textColor: AppColors.kPrimary1,
            onPressed: () {
              dashboardProvider.setPageIndexToHome(context);
            },
          ),
          Gap(10.w),
          DefaultButtonMain(
            padding: EdgeInsets.symmetric(horizontal: 34.w),
            color: AppColors.kPrimary1,
            text: transferred,
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  barrierColor: AppColors.kTransparent,
                  context: context,
                  builder: (context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: TPayDefaultProgressStatusPopUp(
                        progressStatusLogo: AppImages.inProgressLogo,
                        progressStatusTextTitle: inProgress,
                        progressStatusTextBody: yourOrderIsReceivedWillBeNotifiedWithin45Secs,
                        action: DefaultButtonMain(
                          textColor: AppColors.kWhite,
                          color: AppColors.kPrimary1,
                          text: backToHome,
                          onPressed: () {
                            dashboardProvider.setPageIndexToHome(context);
                          },
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}



class BuyCoinScreenItems extends StatelessWidget {
  const BuyCoinScreenItems({
    super.key,
    required this.screenItem,
  });

  final Widget screenItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        screenItem,
        const TampayDivider(),
      ],
    );
  }
}
