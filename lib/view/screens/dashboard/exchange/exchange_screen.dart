import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/screens/dashboard/buy/buy_screen.dart';
import 'package:tampay/view/screens/dashboard/sell%20asset/select_bank_screen.dart';

class ExchangeScreen extends ConsumerStatefulWidget {
  const ExchangeScreen({super.key});

  @override
  ConsumerState<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends ConsumerState<ExchangeScreen>
    with SingleTickerProviderStateMixin {
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
    ref.read(onboardingViewModel).getCryptPayBuyingRates();
    ref.read(onboardingViewModel).getCryptPaySellingRates();

    /// _tabController.addListener(_handleTabChange);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = 360.w;
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    // var walletProvider = ref.watch(walletViewModel);
    var profileProvider = ref.watch(profileViewModel);
    var dashProvider = ref.watch(dashboardViewModel);
    var onboardingProvider = ref.watch(onboardingViewModel);

    ThemeData theme = Theme.of(context);
    return Scaffold(
      // backgroundColor: AppColors.kWhite,
      appBar: AppBars.mainAppBar(
        context,
      ),
      body: XResponsiveWrap.mobile(
        padding: EdgeInsets.symmetric(
          horizontal: 30.w,
        ),

        onRefresh: () async {
          // await  profileProvider.loadData(context).whenComplete((){
          //   walletProvider
          //       .getAcctBalance(userType: profileProvider.profileData?.role!)
          //       .then((value) => marketPlaceProvider.initMarketPlace());
          // });
        },
        //loading: marketPlaceProvider.isGettingPropertiesListings,
        children: [
          SizedBox(
            height: 800.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color:
                        themeMode == ThemeMode.light ? AppColors.kLightMist : AppColors.kEbonyGray,
                  ),
                  child: TabBar(
                      dividerColor: AppColors.kTransparent,
                      controller: _tabController,
                      unselectedLabelColor: AppColors.kCloudGray,
                      labelColor: AppColors.kWhite,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r), color: AppColors.kPrimary1),
                      padding: EdgeInsets.only(
                        left: 3.w,
                        right: 3.w,
                      ),
                      tabs: [
                        Padding(
                            padding: EdgeInsets.all(5.r),
                            child: Text(
                              "Buy Rates",
                              style: TextStyle(
                                fontSize: 20.spMin,
                                fontFamily: soraFont,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(5.r),
                            child: Text(
                              "Sell Rates",
                              style: TextStyle(
                                fontSize: 20.spMin,
                                fontFamily: soraFont,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ]),
                ),
                Gap(20.h),
                TextView(
                  text: "Select an asset to start trading",
                  fontSize: 14.spMin,
                ),
                Gap(20.h),
                Expanded(
                  child: TabBarView(controller: _tabController, children: [
                    ExchangeScreenTradingAssets(
                      onboardingProvider: onboardingProvider,
                      themeMode: themeMode,
                      theme: theme,
                      index: 1,
                    ),
                    ExchangeScreenTradingAssets(
                      onboardingProvider: onboardingProvider,
                      themeMode: themeMode,
                      theme: theme,
                      index: 2,
                    ),
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

class ExchangeScreenTradingAssets extends ConsumerWidget {
  const ExchangeScreenTradingAssets({
    super.key,
    required this.onboardingProvider,
    required this.themeMode,
    required this.theme,
    required this.index,
  });

  final OnboardingViewModel onboardingProvider;
  final ThemeMode themeMode;
  final ThemeData theme;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dashProvider = ref.watch(dashboardViewModel);
    return Column(
      children: List.generate(
        onboardingProvider.tPayCryptoRatesAtBuyingOrSelling(index).length,
        (cryptoListRateIndex) {
          CryptoRatesModel cryptoCoins =
              onboardingProvider.tPayCryptoRatesAtBuyingOrSelling(index)[cryptoListRateIndex];
        
          return GestureDetector(
            onTap: () {
              if (index == 2) {
                navigatePush(context, const SelectBankScreen());
                dashProvider.getCrptoAcronym(cryptoCoins.cryptoAncronym);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 8.w,
              ),
              margin: EdgeInsets.only(bottom: 15.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: themeMode == ThemeMode.dark ? AppColors.kOnyxBlack : AppColors.kLightSilver,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        onboardingProvider.cryptoCoinImages[cryptoListRateIndex],
                        width: 32.w,
                        height: 32.h,
                      ),
                      Gap(3.w),
                      TextView(
                        text: cryptoCoins.crypto ?? "Error",
                        textStyle: theme.textTheme.titleMedium,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      TextView(
                        text: "${cryptoCoins.rate}/$dollarSign",
                        textStyle: theme.textTheme.titleMedium,
                      ),
                      Gap(10.w),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20.spMin,
                        color: themeMode == ThemeMode.light ? AppColors.kGrey900 : AppColors.kWhite,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
