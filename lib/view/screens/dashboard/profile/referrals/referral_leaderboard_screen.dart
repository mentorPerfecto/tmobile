import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';

class ReferralLeaderboardScreen extends ConsumerStatefulWidget {
  const ReferralLeaderboardScreen({super.key});

  @override
  ConsumerState<ReferralLeaderboardScreen> createState() => _ReferralLeaderboardScreenState();
}

class _ReferralLeaderboardScreenState extends ConsumerState<ReferralLeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
     ref.watch(themeViewModel);
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
          TextView(
            text: "You",
            fontSize:  14.spMin,
          ),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "40",),
          const Gap(30),
          TextView(
            text: "Leaderboard",
            fontSize:  20.spMin,
            fontFamily: soraFont,
            fontWeight: FontWeight.w600,
          ),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "1",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "2",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "3",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "4",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "5",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "6",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "7",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "8",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "9",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "11",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "12",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "13",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "14",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "15",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "16",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "17",),
          const ReferralLeaderBoardUser(name: 'Peter', userName: '@peter001',  rank: "18",),
        ],
      ),

    );
  }
}
