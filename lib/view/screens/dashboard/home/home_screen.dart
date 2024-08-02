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
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    // var walletProvider = ref.watch(walletViewModel);
    var profileProvider = ref.watch(profileViewModel);
    var dashProvider = ref.watch(dashboardViewModel);

    ThemeData theme = Theme.of(context);
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36.r),
                      color: AppColors.kCharcoalBlack,
                    ),
                    child: Stack(
                      children: [
                        const MovingCircles(),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ImageView.asset(
                                        AppImages.dummyImage,
                                        width: 36.w,
                                        height: 36.h,
                                      ),
                                      Gap(10.w),
                                      TextView(
                                        text: "Hello, Daniel",
                                        fontSize: 14.sp,
                                        color: AppColors.kWhite,
                                      ),
                                    ],
                                  ),
                                  ImageView.asset(
                                    AppImages.notificationIcon,
                                    width: 32.w,
                                    height: 32.h,
                                  )
                                ],
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Column(
                                children: [
                                  TextView(
                                    text: "TOTAL PAYOUT",
                                    fontSize: 10.spMin,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kWhite,
                                  ),
                                  Gap(15.h),
                                  Row(
                                    children: [
                                      TextView(
                                        text: r"$7,534",
                                        fontSize: 40.spMin,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.kWhite,
                                      ),
                                      Gap(10.w),
                                      Icon(
                                        Icons.visibility_outlined,
                                        color: AppColors.kWhite,
                                        size: 14.spMin,
                                      )
                                    ],
                                  ),
                                  Gap(15.h),
                                  TextView(
                                    text: "~ ${UtilFunctions.currency(context)} 10,234,456",
                                    color: AppColors.kWhite,
                                  )
                                ],
                              ),
                              const Spacer(
                                flex: 2,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                CompleteAccountSetupWarning(themeMode: themeMode, theme: theme),
                SizedBox(
                  width: 237.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SellBuyMore(
                        id: sell,
                        icon: AppImages.arrowDownIcon,
                        backgroundColor: themeMode == ThemeMode.light
                            ? AppColors.kPalePeriwinkle
                            : AppColors.kCharcoalGray,
                        iconColor: theme.colorScheme.primary,
                      ),
                      const SellBuyMore(
                        id: buy,
                        icon: AppImages.arrowUpIcon,
                        backgroundColor: AppColors.kPrimary1,
                        iconColor: AppColors.kWhite,
                      ),
                      SellBuyMore(
                        id: more,
                        icon: AppImages.moreLogo,
                        backgroundColor: themeMode == ThemeMode.light
                            ? AppColors.kPalePeriwinkle
                            : AppColors.kCharcoalGray,
                        iconColor: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.spMin),
                      color: themeMode == ThemeMode.dark
                          ? AppColors.kDarkSlateGrey
                          : AppColors.kTransparentCharcoal,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ImageView.asset(
                          AppImages.zapLogo,
                          width: 18.w,
                          height: 18.h,
                        ),
                        const TextView(
                          text: "View rates",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SellBuyMore extends StatelessWidget {
  const SellBuyMore({
    super.key,
    required this.id,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });
  final String id;
  final Color backgroundColor;
  final Color iconColor;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 45.w,
          height: 45.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
          child: Center(
            child: ImageView.asset(
              icon,
              width: 16.w,
              height: 10.h,
              color: iconColor,
            ),
          ),
        ),
        Gap(10.h),
        TextView(
          text: id,
          fontSize: 14.spMin,
        )
      ],
    );
  }
}

class CompleteAccountSetupWarning extends StatelessWidget {
  const CompleteAccountSetupWarning({
    super.key,
    required this.themeMode,
    required this.theme,
  });

  final ThemeMode themeMode;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 12.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: themeMode == ThemeMode.dark ? AppColors.kDarkBronze : AppColors.kSoftPeach,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageView.asset(
                AppImages.warningLogo,
                width: 24.w,
                height: 24.h,
                color: themeMode == ThemeMode.light ? AppColors.kGoldenOrange : null,
              ),
              Gap(15.w),
              TextView(
                text: "Complete Account Setup",
                color:
                    themeMode == ThemeMode.dark ? AppColors.kAmberOrange : AppColors.kGoldenOrange,
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 24.spMin,
            color: theme.colorScheme.primary,
          )
        ],
      ),
    );
  }
}
