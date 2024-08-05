import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/view/screens/dashboard/buy/buy_screen.dart';
import 'package:tampay/view/screens/dashboard/sell/sell_screen.dart';

class ExchangeScreen extends ConsumerStatefulWidget {
  const ExchangeScreen({super.key});


  @override
  ConsumerState<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends ConsumerState<ExchangeScreen>    with SingleTickerProviderStateMixin {
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
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = ref.read(dashboardViewModel).exchangeCurrentIndex;
    /// _tabController.addListener(_handleTabChange);
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = 360.w;
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    // var walletProvider = ref.watch(walletViewModel);
    var profileProvider = ref.watch(profileViewModel);
    var dashProvider = ref.watch(dashboardViewModel);

    ThemeData theme = Theme.of(context);
    return Scaffold(
      // backgroundColor: AppColors.kWhite,
      body: XResponsiveWrap.mobile(
        padding: EdgeInsets.all(15.r),

        onRefresh: () async {
          // await  profileProvider.loadData(context).whenComplete((){
          //   walletProvider
          //       .getAcctBalance(userType: profileProvider.profileData?.role!)
          //       .then((value) => marketPlaceProvider.initMarketPlace());
          // });
        },
        //loading: marketPlaceProvider.isGettingPropertiesListings,
        children: [
          const Gap(30),
          SizedBox( height: 800.h,
            child: Column(
              children: [
                Expanded( flex: 1,

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TabBar(
                        controller: _tabController,
                        unselectedLabelColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: AppColors.kPrimary1),
                        padding: EdgeInsets.only(
                          left: 3.w,
                          right: 3.w,
                        ),
                        tabs: [
                          Padding(
                            padding: EdgeInsets.all(8.r),
                            child: TextView(
                              text:  'Pending',
                              fontSize: 14.spMin,
                              fontWeight: FontWeight.bold,

                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.r),
                            child: TextView(
                              text:  'Pending',
                              fontSize: 14.spMin,
                              fontWeight: FontWeight.bold,

                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Expanded( flex: 15,
                  //   height: 625.h,
                  child: TabBarView(controller: _tabController,

                      children: const [
                        BuySectionScreen(),
                        SellSectionScreen()
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
