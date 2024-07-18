// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/screens/dashboard/buy/buy_screen.dart';
import 'package:tampay/view/screens/dashboard/profile/profile_screen.dart';
import 'package:tampay/view/screens/dashboard/sell/sell_screen.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  final int? setIndex;
  final bool isSignUp;

  const DashBoardScreen({super.key, this.setIndex,  this.isSignUp = false});

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  @override
  void initState() {

    /// ref.read(dashboardViewModel).initDashboard(widget.setIndex ?? 0);

    // var profileProvider = ref.read(profileViewModel);
    // var dashProvider = ref.read(dashboardViewModel);

    Future.microtask(() {
      // profileProvider.loadData(context).then((value) => ref
      //     .read(walletViewModel)
      //     .getAcctBalance(userType: profileProvider.profileData?.role ?? 0));
      //
      // marketPlaceProvider.initMarketPlace();
      // dashProvider.getDeviceLocation();
      // listingProvider.getPersonalProperties(context);
      // listingProvider.getPersonalUnverifiedProperties(context);
    });
    super.initState();
  }

  // int profileProvider.currentIndex = 0;
  List<Widget> dashboardPages = [
    const HomeScreen(),
    const BuySectionScreen(),
    const SellSectionScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var profileProvider = ref.watch(profileViewModel);
    var dashProvider = ref.watch(dashboardViewModel);
    var themeMode = ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        bool exit = await displayExitDialog(
          context,
          theme: theme,
          themeMode: themeMode,
        );
        return exit;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   actions: [Container()],
        //   backgroundColor: theme.scaffoldBackgroundColor,
        //   automaticallyImplyLeading: false,
        //   title: TextView(
        //     text: "dashProvider.getTitle(2).toString()",
        //     textStyle: theme.textTheme.titleLarge!.copyWith(
        //       fontSize: 20.spMin,
        //     ),
        //   ),
        //   centerTitle: false,
        //   leadingWidth: 50,
        //   leading: dashProvider.currentIndex == 0 &&
        //           int.parse(profileProvider.profileData?.role?.toString() ?? '1') > 1
        //       ? Center(
        //           //
        //           child: ProfileImage(
        //           imageType: ProfileImageType.user,
        //           imageUrl: profileProvider.profileData?.profileImage ?? 'ded',
        //           width: 40.w,
        //           height: 40.h,
        //         ))
        //       : null,
        // ),
        body: dashboardPages[dashProvider.currentIndex],
        backgroundColor: theme.scaffoldBackgroundColor,
        bottomNavigationBar: Container(
          height: 74.h,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                topLeft: Radius.circular(16.r)),
            // boxShadow: [
            //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            // ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            child: BottomNavigationBar(
              showUnselectedLabels: true,
              useLegacyColorScheme: false,
              backgroundColor: theme.scaffoldBackgroundColor,
              selectedItemColor: AppColors.kPrimary1,
              unselectedItemColor: AppColors.kUnselectedBottomItemColor,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyle(
                fontFamily: soraFont,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontFamily: soraFont,
                fontSize: 12.sp,
                color: AppColors.kUnselectedBottomItemColor,
                fontWeight: FontWeight.w600,
              ),
              items: [
                BottomNavigationBarItem(
                    icon: ImageView.asset(
                        // dashProvider.currentIndex == 0

                        AppImages.dashboardHomeLogo,
                        width: 20.w,
                        height: 20.h,
                        color: dashProvider.currentIndex == 0
                            ? AppColors.kPrimary1
                            : null),
                    label: home),
                BottomNavigationBarItem(
                    icon: ImageView.asset(
                      AppImages.dashboardBuyLogo,
                      width: 22.w,
                      height: 22.h,
                        color: dashProvider.currentIndex == 1
                            ? AppColors.kPrimary1
                            : null
                    ),
                    label: buy),
                BottomNavigationBarItem(
                    icon: ImageView.asset(
                      AppImages.dashboardSellLogo,
                      width: 22.w,
                      height: 22.h,
                        color: dashProvider.currentIndex == 2
                            ? AppColors.kPrimary1
                            : null
                    ),
                    label: sell),
                BottomNavigationBarItem(
                    icon: ImageView.asset(
                      AppImages.profileLogo,
                      width: 22.w,
                      height: 22.h,
                        color: dashProvider.currentIndex == 3
                            ? AppColors.kPrimary1
                            : null
                    ),
                    label: profile),

              ],
              onTap: (index) {
                // dashProvider.getDeviceLocation();
                dashProvider.setPageIndex(selectedPageIndex: index);
              },
              currentIndex: dashProvider.currentIndex,
            ),
          ),
        ),
      ),
    );
  }
}

