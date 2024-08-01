import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/utils.dart';

class ReferAndEarnScreen extends ConsumerStatefulWidget {
  ReferAndEarnScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends ConsumerState<ReferAndEarnScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
     
        text: "Referrals",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 15.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InviteFriendCard(
                title: "Refer and Earn 25% Commission",
                subText: "Invite your friends to create an account and start trading, "
                    "you can earn up to 25% from their trading fees",
              ),
              Gap(20.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: "My Referrals",
                    fontSize: 20.spMin,
                    fontWeight: FontWeight.w600,
                  ),
                  Gap(22.h),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReferralsDetailBox(
                        detailLogo: AppImages.piggyBankLogo,
                        detailTitle: "You've Earned",
                        detailValue: "₦25,550.65",
                      ),
                      ReferralsDetailBox(
                        detailLogo: AppImages.referralsInvitesLogo,
                        detailTitle: "You've  Invited",
                        detailValue: "124 friends",
                      ),
                    ],
                  ),
                  Gap(20.h),
                  const ReferralLinkCode(
                    label: "Referral Link",
                    title: "Referral link",
                    value: "https://tamp.....co/212324",
                  ),
                  Gap(20.h),
                  const ReferralLinkCode(
                    label: "Referral Code",
                    title: "Code",
                    value: "2qdd12324",
                  ),
                ],
              ),
              Gap(60.h),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.kGrey700,
                    width: 0.5.w,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: "How it works",
                      fontSize: 14.spMin,
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReferralLinkCode extends StatelessWidget {
  const ReferralLinkCode({
    super.key,
    required this.label,
    required this.title,
    required this.value,
  });
  final String label;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: label,
          fontSize: 14.spMin,
        ),
        Gap(5.h),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 12.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.kNavyBlue,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: title,
                fontSize: 14.spMin,
                color: AppColors.kDesaturatedDarkBlue,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: value,
                    fontSize: 14.spMin,
                  ),
                  Gap(8.w),
                  GestureDetector(
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: value));
                      showToast(msg: "Copied successfully", isError: false);
                    },
                    child: Image.asset(
                      AppImages.copyLogo,
                      width: 20.w,
                      height: 20.h,
                      color: AppColors.kPrimary1,
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class ReferralsDetailBox extends StatelessWidget {
  const ReferralsDetailBox({
    super.key,
    required this.detailLogo,
    required this.detailTitle,
    required this.detailValue,
  });
  final String detailLogo;
  final String detailTitle;
  final String detailValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 23.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.kGrey700),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        children: [
          Image.asset(
            detailLogo,
            width: 32.w,
          ),
          Gap(20.h),
          TextView(
            text: detailTitle,
            fontSize: 14.spMin,
          ),
          Gap(10.h),
          TextView(
            text: detailValue,
            fontSize: 20.spMin,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }
}
