// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/screens/dashboard/buy/buy_screen.dart';
import 'package:tampay/view/screens/dashboard/profile/profileScreen.dart';
import 'package:tampay/view/screens/dashboard/sell/sell_screen.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  final int? setIndex;

  const DashBoardScreen({super.key, this.setIndex});

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
        appBar: AppBar(
          actions: [Container()],
          backgroundColor: theme.scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          title: TextView(
            text: "dashProvider.getTitle(2).toString()",
            textStyle: theme.textTheme.titleLarge!.copyWith(
              fontSize: 20.spMin,
            ),
          ),
          centerTitle: false,
          leadingWidth: 50,
          leading: dashProvider.currentIndex == 0 &&
                  int.parse(profileProvider.profileData?.role?.toString() ?? '1') > 1
              ? Center(
                  //
                  child: ProfileImage(
                  imageType: ProfileImageType.user,
                  imageUrl: profileProvider.profileData?.profileImage ?? 'ded',
                  width: 40.w,
                  height: 40.h,
                ))
              : null,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: dashboardPages[dashProvider.currentIndex],
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          useLegacyColorScheme: false,
          backgroundColor: theme.scaffoldBackgroundColor,
          selectedItemColor:
              themeMode == ThemeMode.light ? AppColors.kPrimary1 : AppColors.kPrimary150,
          unselectedItemColor: theme.colorScheme.secondary,
          selectedLabelStyle: TextStyle(
            fontFamily: ttHoves,
            fontSize: 10.spMin,
            fontWeight: FontWeight.w400,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: ttHoves,
            fontSize: 10.spMin,
            fontWeight: FontWeight.w400,
          ),
          items: //write a ternary operator for the tenant,cause it should have only four navigation bar items.
              [
            // BottomNavigationBarItem(
            //     icon: Image.asset(
            //       dashProvider.currentIndex == 0
            //           ? themeMode == ThemeMode.light
            //           ? AppImages.selectedHome
            //           : AppImages.selectedHomeDark
            //           : AppImages.home,
            //       width: 24.w,
            //       height: 24.h,
            //     ),
            //     label: home),
            // BottomNavigationBarItem(
            //     icon: Image.asset(
            //       dashProvider.currentIndex == 1
            //           ? themeMode == ThemeMode.light
            //           ? AppImages.selectedMarket
            //           : AppImages.selectedMarketPlaceDark
            //           : AppImages.shop,
            //       width: 24.w,
            //       height: 24.h,
            //     ),
            //     label: marketPlace),
            // BottomNavigationBarItem(
            //     icon: Image.asset(
            //       dashProvider.currentIndex == 2
            //           ? themeMode == ThemeMode.light
            //           ? AppImages.selectedProperties
            //           : AppImages.selectedPropertiesDark
            //           : AppImages.properties,
            //       width: 24.w,
            //       height: 24.h,
            //     ),
            //     label: properties),
            // if (profileProvider.profileData?.role != 2)
            //   BottomNavigationBarItem(
            //     icon: Image.asset(
            //       dashProvider.currentIndex == 3
            //           ? themeMode == ThemeMode.light
            //           ? AppImages.selectedWallet
            //           : AppImages.selectedWalletDark
            //           : AppImages.wallet,
            //       width: 24.w,
            //       height: 24.h,
            //     ),
            //     label: wallet,
            //   ),
            // BottomNavigationBarItem(
            //   icon: Image.asset(
            //     dashProvider.currentIndex == 4
            //         ? themeMode == ThemeMode.light
            //         ? AppImages.selectedMore
            //         : AppImages.selectedMoreDark
            //         : AppImages.more,
            //     width: 24.w,
            //     height: 24.h,
            //   ),
            //   label: more,
            // ),
          ],
          onTap: (index) {
            // dashProvider.getDeviceLocation();
            dashProvider.setBottomBarItem(context, index);
            ref
                .watch(authViewModel)
                .updateRole(int.parse(profileProvider.profileData?.role.toString() ?? '1'));
            // ref.watch(profileViewModel).fetchKYC(context);
          },
          currentIndex: dashProvider.currentIndex,
        ),
      ),
    );
  }
}
