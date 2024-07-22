import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/config/app_strings.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';

class VerifyAccountLevelScreen extends ConsumerWidget {
  const VerifyAccountLevelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    List<String> _level2VerificationDetails = [dateOfBirth, bvnNumberText];
    List<String> _level1VerificationDetails = [emailText, phoneNumberText, userName];
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
        backgroundColor: theme.scaffoldBackgroundColor,
        arrowBackColor: theme.colorScheme.primary,
        text: verifyAccountTextInCaps,
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
                GestureDetector(
                  onTap: () {
                    navigatePush(context, const DateOfBirthVerificationScreen());
                  },
                  child: VerificationLevel(
                    level2VerificationDetails: _level2VerificationDetails,
                    verificationLogo: AppImages.verifiedBadgeLogo,
                    level: level2,
                    verificationStatus: const VerificationTextButton(isProfileScreen: false),
                  ),
                ),
                Gap(25.h),
                VerificationLevel(
                  level2VerificationDetails: _level1VerificationDetails,
                  verificationLogo: AppImages.verifiedBadgeLogo,
                  level: level1,
                  verificationStatus: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                        color: const Color(0xFFCCFCD1), borderRadius: BorderRadius.circular(4.r)),
                    child: Center(
                      child: TextView(
                        text: verified,
                        fontSize: 10.spMin,
                        color: const Color(0xFF009A47),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerificationLevel extends StatelessWidget {
  const VerificationLevel({
    super.key,
    required List<String> level2VerificationDetails,
    required this.level,
    required this.verificationLogo,
    required this.verificationStatus,
  }) : _level2VerificationDetails = level2VerificationDetails;

  final List<String> _level2VerificationDetails;
  final String verificationLogo;
  final String level;
  final Widget verificationStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5.w,
          color: AppColors.kGrey700,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 24.h,
                    width: 91.w,
                    child: Row(
                      children: [
                        Image.asset(
                          verificationLogo,
                          width: 24.w,
                          height: 24.h,
                        ),
                        Gap(10.w),
                        TextView(
                          text: level,
                          fontSize: 14.spMin,
                        ),
                      ],
                    ),
                  ),
                  verificationStatus,
                ],
              ),
              Gap(8.h),
              const TampayDivider()
            ],
          ),
          BulletList(list: _level2VerificationDetails),
        ],
      ),
    );
  }
}
