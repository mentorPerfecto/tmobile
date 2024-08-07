import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';

class AccountUpgradeScreen extends ConsumerWidget {
  const AccountUpgradeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dashProvider = ref.watch(dashboardViewModel);
    return Scaffold(
      backgroundColor: AppColors.kCharcoalBlack,
    
      body: Stack(
        children: [
          const MovingCircles(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 15.0.w, right: 15.w, bottom: 15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          
                          GestureDetector(
                            onTap: () {
                              navigatePush(context, CreatePasswordScreen());
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 18.r,
                              color: AppColors.kWhite,
                            ),
                          ),
                          TextView(
                            text: back,
                            fontSize: 14.spMin,
                            fontFamily: soraFont,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kWhite,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: TextView(
                          text: "Skip",
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w600,
                          color: AppColors.kPrimary1,
                          onTap: () {
                            dashProvider.setPageIndexToHome(context);
                          },
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, children: [
                    TextView(
                      text: "You need to upgrade\nYour account first",
                      fontSize: 20.spMin,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kWhite,
                    ),
                    
                  
                    Gap(25.h),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColors.kOnyxBlack,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: "Tier 2",
                            fontSize: 14.spMin,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kWhite,
                          ),
                          Gap(20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextView(
                                text: "Daily Transaction Limit",
                                color: AppColors.kGrey400,
                              ),
                              TextView(
                                text: "₦ ${UtilFunctions.formatAmount(1000000)}",
                                color: AppColors.kGrey100,
                              ),
                            ],
                          ),
                          Gap(15.h),
                          const TextView(
                            text: "Unlimited Sell and Buy",
                            color: AppColors.kGrey400,
                          ),
                          Gap(15.h),
                          const TextView(
                            text: "More Bank Accounts",
                            color: AppColors.kGrey400,
                          ),
                          Gap(20.h),
                          const TextView(
                            text: "Requirements",
                            color: AppColors.kGrey100,
                          ),
                          Gap(15.h),
                          Row(
                            children: [
                              ImageView.asset(
                                AppImages.checkmarkCircleIcon,
                                width: 16.w,
                                height: 16.h,
                              ),
                              Gap(10.w),
                              const TextView(
                                text: "Government ID",
                                color: AppColors.kGrey400,
                              ),
                            ],
                          ),
                          Gap(15.h),
                          Row(
                            children: [
                              ImageView.asset(
                                AppImages.checkmarkCircleIcon,
                                width: 16.w,
                                height: 16.h,
                              ),
                              Gap(10.w),
                              const TextView(
                                text: "House Address",
                                color: AppColors.kGrey400,
                              ),
                            ],
                          ),
                          Gap(15.h),
                          Row(
                            children: [
                              ImageView.asset(
                                AppImages.checkmarkCircleIcon,
                                width: 16.w,
                                height: 16.h,
                              ),
                              Gap(10.w),
                              const TextView(
                                text: "Utility Bill of House Address",
                                color: AppColors.kGrey400,
                              ),
                            ],
                          ),
                          Gap(15.w),
                          DefaultButtonMain(
                            color: AppColors.kPrimary1,
                            width: 195.w,
                            text: "Click to start upgrade",
                          )
                        ],
                      ),
                    )
                  ]),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
