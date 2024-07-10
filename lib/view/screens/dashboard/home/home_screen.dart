import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void didChangeDependencies() {
    // ref.watch(marketPlaceViewModel).initMarketPlace();
    // var  profileProvider = ref.watch(profileViewModel);
    //
    //
    // Future.microtask((){
    //   profileProvider.loadData(context).then((value) => ref
    //       .watch(walletViewModel)
    //       .getAcctBalance(userType: profileProvider.profileData?.role ?? 0));
    // });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = 360.w;
    ref.watch(themeViewModel).themeMode;
   // var walletProvider = ref.watch(walletViewModel);
    var profileProvider = ref.watch(profileViewModel);
    var dashProvider = ref.watch(dashboardViewModel);

    var theme = Theme.of(context);
    return Scaffold(
      // backgroundColor: AppColors.kWhite,
      body: XResponsiveWrap.mobile(
        onRefresh: () async {
          // await  profileProvider.loadData(context).whenComplete((){
          //   walletProvider
          //       .getAcctBalance(userType: profileProvider.profileData?.role!)
          //       .then((value) => marketPlaceProvider.initMarketPlace());
          // });

        },
        //loading: marketPlaceProvider.isGettingPropertiesListings,
        children: [
          Gap(10.h),
          AccountBalanceContainer(
            role: int.parse(
                profileProvider.profileData?.role.toString() ?? '1'),
            actionText:
                //  int.parse(profileProvider.profileData!.role.toString()) == 2 ?
                fundAccount,
            // : withdrawText,
            onTap: () {
            },
            screenWidth: screenWidth,
            accountBalanceButtonWidth: screenWidth,
            usersAccountBalance: "0",
           // usersAccountBalance: walletProvider.acctBalance!,
          ),
          // int.parse(profileProvider.profileData!.role.toString()) > 1
          //     ?
          // profileProvider.kycResponseStatus?.data == null
          //     ? AccountVerification(screenWidth: screenWidth)
          //     : Container(),
          Gap(20.h),

        ],
      ),
    );
  }
}
