import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view_model/theme_view_model.dart';

class VerifyAccountLevelScreen extends ConsumerWidget {
  const VerifyAccountLevelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    List<String> tier2VerificationDetails = ["Government  ID", 'House Address', 'Utility Bill of House Address'];
    List<String> tier2Access = ['Unlimited Sell and Buy', 'More Bank Accounts' ];
    List<String> tier1Access = ['Sell Only', 'One Bank Accounts' ];
    List<String> tier1VerificationDetails = [emailText, bvnNumberText, liveliness];
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
     
        bottomText: "Account Upgrade",
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 15.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(25.h),
                VerificationLevel(
                  levelVerificationDetails: tier1VerificationDetails,
                  verificationLogo: AppImages.verifiedBadgeLogo, dtl: '10000000',
                  level: level1, isCompleted: true, levelAccess: tier1Access,
                ),
                const Gap(25),
                VerificationLevel(
                  levelVerificationDetails: tier2VerificationDetails, dtl: '10000000',
                  verificationLogo: AppImages.verifiedBadgeLogo, isCompleted: false,
                  level: level2, levelAccess: tier2Access,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerificationLevel extends ConsumerWidget {


  final List<String> levelVerificationDetails;
  final List<String> levelAccess;
  final String verificationLogo;
  final String level;
  final String dtl;
  final bool isCompleted;

  const VerificationLevel({super.key, required this.levelVerificationDetails,
    required this.verificationLogo, required this.level, required this.levelAccess, required this.dtl,
    required this.isCompleted});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeMode = ref.watch(themeViewModel).themeMode;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 25.h, ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              color: themeMode == ThemeMode.dark ? AppColors.kOnyxBlack : AppColors.kLightSilver,
              border: Border.all(
                width: 2.w,
                color:  isCompleted ? AppColors.kLimeGreen: AppColors.kTransparent,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isCompleted? const Gap(30) : const SizedBox.shrink(),

                TextView(
                  text: level,
                  fontSize: 14.spMin, fontWeight: FontWeight.bold,
                ),
                const Gap(8),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextView(
                      text: 'Daily Transaction Limit', color: AppColors.kGrey600,
                    ),

                    TextView(
                      text: 'N ${UtilFunctions.formatAmount(double.parse(dtl))}',
                    ),
                  ],
                ),
                const Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: levelAccess.map<Widget>((listDetails) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: TextView(
                        text: listDetails,
                        softRap: true, color: AppColors.kGrey600,
                      ),
                    );
                  }).toList(),
                ),
                const Gap(8),

                const TextView(
                  text: 'Requirements',
                ),
                const Gap(8),
                BulletList(list: levelVerificationDetails, isCompleted: isCompleted,),
                const Gap(15),
                !isCompleted ? DefaultButtonMain( color: AppColors.kPrimary1,
                  text: 'Click to start upgrade', width: 180.w,): const SizedBox.shrink()
              ],
            ),
          ),
        ),
        isCompleted? Padding(
          padding: EdgeInsets.only(left: 20.h, ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.kLimeGreen,
              border: Border.all(
                width: 2.w,
                color:  isCompleted ? AppColors.kLimeGreen: AppColors.kTransparent,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ), height: 40.h, width: 100.w,
            child: const Center(child: TextView(text: 'Current Tier', color: AppColors.kWhite,)),
          ),
        ): const SizedBox.shrink()
      ],
    );
  }
}
