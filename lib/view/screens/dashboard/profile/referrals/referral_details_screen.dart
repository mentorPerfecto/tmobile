import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/screens/dashboard/profile/referrals/referral_leaderboard_screen.dart';

class ReferralDetailsScreen extends ConsumerStatefulWidget {
  const ReferralDetailsScreen({super.key});

  @override
  ConsumerState<ReferralDetailsScreen> createState() => _ReferralDetailsScreenState();
}

class _ReferralDetailsScreenState extends ConsumerState<ReferralDetailsScreen> {
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

          const Gap(30),

          DefaultButtonMain(borderColor: AppColors.kPrimary1, text: 'View Leaderboard', textColor: AppColors.kPrimary1,
            onPressed: (){ navigatePush(context, const ReferralLeaderboardScreen());
            },),

          const Gap(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: "Invited friends",
                fontSize:  20.spMin,
                fontFamily: soraFont,
                fontWeight: FontWeight.w600,
              ),

            ],
          ),
          const Gap(20),
          ReferralUser(name: 'Peter', amount: '235', date: DateTime.now().toString(),),
          ReferralUser(name: 'Peter', amount: '235', date: DateTime.now().toString(),),
          ReferralUser(name: 'Peter', amount: '235', date: DateTime.now().toString(),),
          ReferralUser(name: 'Peter', amount: '235', date: DateTime.now().toString(),),
          ReferralUser(name: 'Peter', amount: '235', date: DateTime.now().toString(),),
        ],
      ),

    );
  }
}
