import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/screens/dashboard/profile/referrals/referral_details_screen.dart';

class ReferAndEarnScreen extends ConsumerStatefulWidget {
  const ReferAndEarnScreen({super.key});

  @override
  ConsumerState<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends ConsumerState<ReferAndEarnScreen> {
  @override
  Widget build(BuildContext context) {
    var  themeMode = ref.watch(themeViewModel).themeMode;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context, bottomVisible: false
      ),
      body:   XResponsiveWrap.mobile(
        padding:  EdgeInsets.symmetric( vertical: 15.h,  horizontal: 15.w,),
        onRefresh: () async {
          // await  profileProvider.loadData(context).whenComplete((){
          //   walletProvider
          //       .getAcctBalance(userType: profileProvider.profileData?.role!)
          //       .then((value) => marketPlaceProvider.initMarketPlace());
          // });
        },
        //loading: marketPlaceProvider.isGettingPropertiesListings,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: "Referrals",
                fontSize:  20.spMin,
                fontFamily: soraFont,
                fontWeight: FontWeight.w600,
              ),
              const TextView(
                text: "Invite Friends", color: AppColors.kPrimary1,
              ),
            ],
          ),
          Gap(20.h),
          const InviteFriendCard(
            title: "Refer and Earn 25% Commission",
            subText: "Invite your friends and earn up to 25% from their trading fees",
          ),
          Gap(20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ReferralsDetailBox(
                detailLogo: AppImages.piggyBankLogo,
                detailTitle: "Earnings",
                detailValue: "₦25,550.65",
                color: AppColors.kPrimary1, textColor: AppColors.kWhite,
              ),
              ReferralsDetailBox( color:  themeMode == ThemeMode.light ? AppColors.kLightSilver : AppColors.kOnyxBlack,
                detailLogo: AppImages.referralsInvitesLogo,
                detailTitle: "Number of Invites",
                detailValue: "124", textColor:  themeMode == ThemeMode.dark ? AppColors.kLightSilver : AppColors.kBlack8,
              ),
            ],
          ),
          Gap(20.h),
          const ReferralLinkCode(
            label: "Referral Code",
            title: "Code",
            value: "daniel001",
          ),
          Gap(20.h),
          const ReferralLinkCode(
            label: "Referral Link",
            title: "Referral link",
            value: "https://www.tampay.com/daniel001",
          ),

          Gap(60.h),

          DefaultButtonMain(color: AppColors.kPrimary1, text: 'Referral details',
          onPressed: (){
            navigatePush(context, const ReferralDetailsScreen());
          },)

        ],
      ),

    );
  }
}

class ReferralLinkCode extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    var themeMode = ref.watch(themeViewModel).themeMode;
    var dashProvider = ref.watch(dashboardViewModel);
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
            color:  themeMode == ThemeMode.light ? AppColors.kLightSilver : AppColors.kOnyxBlack,
          ),
          child: Row(
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
                  AppImages.copyIcon,
                  width: 20.w,
                  height: 20.h,
                  color: AppColors.kPrimary1,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}


