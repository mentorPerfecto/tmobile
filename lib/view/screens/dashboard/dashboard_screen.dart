// ignore_for_file: deprecated_member_use


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  final int? setIndex;

  const DashBoardScreen({super.key, this.setIndex, });

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
    TransactionScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // var profileProvider = ref.watch(profileViewModel);
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
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          useLegacyColorScheme: false,
          backgroundColor: theme.scaffoldBackgroundColor,
          selectedItemColor: AppColors.kPrimary1,
          unselectedItemColor: AppColors.kGrey500,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            fontFamily: soraFont,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: soraFont,
            fontSize: 12.sp,
            color: AppColors.kGrey500,
            fontWeight: FontWeight.w600,
          ),
          items: [
            BottomNavigationBarItem(
              label: "",
              icon: ImageView.asset( AppImages.dashboardHomeLogo,
                  width: 20.w,
                  height: 20.h,
                  color: dashProvider.currentIndex == 0 ? AppColors.kPrimary1 : null),
            ),
            BottomNavigationBarItem(  label: "",
              icon: ImageView.asset(AppImages.transactionsLogo,
                  width: 22.w,
                  height: 22.h,
                  color: dashProvider.currentIndex == 1 ? AppColors.kPrimary1 : null),
            ),
            BottomNavigationBarItem(  label: "",
              icon: ImageView.asset(AppImages.profileLogo,
                  width: 22.w,
                  height: 22.h,
                  color: dashProvider.currentIndex == 2 ? AppColors.kPrimary1 : null),
            ),
          ],
          onTap: (index) {
            // dashProvider.getDeviceLocation();
            dashProvider.setPageIndex(selectedPageIndex: index);
          },
          currentIndex: dashProvider.currentIndex,
        ),
      ),
    );
  }
}

