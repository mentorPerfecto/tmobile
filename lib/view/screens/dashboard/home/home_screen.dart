import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/utils/enums.dart';


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
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        actions: [
          ImageView.asset(
            AppImages.referActionLogo,
            width: 20.w,
          ),
          SizedBox(
            width: 12.w,
          ),
          Padding(
            padding: EdgeInsets.only(right: 18.w),
            child: GestureDetector(
                onTap: () {
                  navigatePush(context, NotificationScreen());
                },
                child: ImageView.asset(
                  AppImages.notificationLogo,
                  width: 20.w,
                )),
          ),
        ],
        backgroundColor: theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: TextView(
          text: 'Hi 0xdaniel',
          fontSize: 14.spMin,
        ),
        centerTitle: false,
        leadingWidth: 50.r,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              //
              child: ProfileImage(
            imageType: ProfileImageType.user,
            imageUrl: profileProvider.profileData?.profileImage ?? 'ded',
            width: 40.w,
            height: 40.h,
          )),
        ),
      ),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0.w),
            child: Column(
              children: [
                Gap(10.h),
                AccountBalanceContainer(
                  role: int.parse(profileProvider.profileData?.role.toString() ?? '1'),
                  actionText:
                      //  int.parse(profileProvider.profileData!.role.toString()) == 2 ?
                      fundAccount,
                  // : withdrawText,
                  onTap: () {},
                  screenWidth: screenWidth,
                  accountBalanceButtonWidth: screenWidth,
                  usersAccountBalance: "0",
                  // usersAccountBalance: walletProvider.acctBalance!,
                ),
                Gap(20.h),
                InviteFriendCard(),
                Gap(24.h),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(text: currentRates),
                    TextView(text: buy),
                  ],
                ),
                SizedBox(
                  height: 14.h,
                ),
                listItems(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  listItems() {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        // Check if it's the last item
        bool isLastItem = index == 9;

        return Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
              ),
              child: CoinListView(
                imageUrl: AppImages.btcLogo,
                coinPrice: 'NGN2,806/\$',
                coinName: 'Bitcoin',
                coinTicker: 'BTC',
                onTap: () {},
              ),
            ),
            if (!isLastItem) TampayDivider(),
          ],
        );
      },
    );
  }
}
