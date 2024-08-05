import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/utils/blur.dart';
import 'package:tampay/utils/enums.dart';
import 'package:tampay/view/screens/dashboard/exchange/exchange_screen.dart';
import 'package:tampay/view_model/dashboard/wallet_view_model.dart';

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
    var walletProvider = ref.watch(walletViewModel);
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
          Container( height: 450.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36.r),
              color: AppColors.kCharcoalBlack,
            ),
            child: Stack(
              children: [
              MovingCircles( height: 450, borderRadius: BorderRadius.circular(36.r),),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              walletProvider.showWalletBal ?
                              RichText( text: TextSpan(
                                text: r"$56,590.",
                                style: TextStyle(
                                  fontSize: 40.spMin,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.kWhite,
                                  fontFamily: soraFont
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '08',
                                    style: TextStyle(
                                      fontSize: 40.spMin,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.kGrey500,
                                        fontFamily: soraFont
                                    ),
                                  ),
                                ],
                              ),) :


                              TextView(
                                text:"****",
                                fontSize: 40.spMin,
                                fontWeight: FontWeight.w400,
                                color: AppColors.kWhite,
                              ),
                              Gap(10.w),
                              GestureDetector(
                                onTap: walletProvider.toggleWalletBal ,
                                child: Icon(
                                  Icons.visibility_outlined,
                                  color: AppColors.kWhite,
                                  size: 14.spMin,
                                ),
                              )
                            ],
                          ),
                          Gap(15.h),
                          TextView(
                            text: "~ ${UtilFunctions.currency(context)} 10,234,456.oo",
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
          CompleteAccountSetupWarning(themeMode: themeMode, theme: theme),
          Padding(
            padding:  EdgeInsets.only(left:50.w,  right:  50.w, top: 15.w),
            child: SizedBox(
              width: 200.w,
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
          ),

          Padding(
            padding: EdgeInsets.only(top: 30.h, bottom: 15.h),
            child: GestureDetector(
              onTap: () async {
                await showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.black38,
                    context: context,
                    builder: (context) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: TPayDefaultPopUp(
                          action: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HomeItems(
                                theme: theme,
                                icon: AppImages.zapLogo,
                                onPressed: () {},
                                subText: "See exciting trading rates",
                                title: "View Rate",
                              ),
                              HomeItems(
                                theme: theme,
                                icon: AppImages.friendsIcon,
                                onPressed: () {},
                                subText: "Earn commission from referrals",
                                title: "Refer A Friend",
                              ),
                              HomeItems(
                                theme: theme,
                                icon: AppImages.bankIcon,
                                onPressed: () {},
                                subText: "View your payout bank accounts",
                                title: "Bank Details",
                              ),
                              const DarkModeItem()
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal:120.w),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.spMin),
                    color: themeMode == ThemeMode.dark
                        ? AppColors.kDarkSlateGrey
                        : AppColors.kTransparentCharcoal,
                  ),
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
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
            ),
          ),
        ],
      ),
    );
  }
}

class HomeItems extends ConsumerWidget {
  const HomeItems({
    super.key,
    required this.theme,
    required this.icon,
    required this.onPressed,
    required this.subText,
    required this.title,
  });

  final ThemeData theme;
  final String icon;
  final String title;
  final String subText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeMode == ThemeMode.dark ? AppColors.kGrey200 : AppColors.kPrimary1,
                ),
                child: Center(
                  child: ImageView.asset(
                    icon,
                    width: 9.w,
                    height: 13.h,
                    color: themeMode == ThemeMode.dark ? AppColors.kWhite : AppColors.kGrey900,
                  ),
                ),
              ),
              Gap(10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: title,
                    fontSize: 14.spMin,
                  ),
                  Gap(15.h),
                  TextView(
                    text: subText,
                    color: themeMode == ThemeMode.light ? AppColors.kGrey500 : AppColors.kGrey400,
                  ),
                ],
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 18.r,
            color: theme.colorScheme.primary,
          )
        ],
      ),
    );
  }
}

class DarkModeItem extends ConsumerWidget {
  const DarkModeItem({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeProvider = ref.watch(themeViewModel);
    ThemeMode themeMode = themeProvider.themeMode;
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeMode == ThemeMode.dark ? AppColors.kGrey200 : AppColors.kPrimary1,
                ),
                child: Center(
                  child: ImageView.asset(
                    "",
                    width: 9.w,
                    height: 13.h,
                    color: themeMode == ThemeMode.dark ? AppColors.kWhite : AppColors.kGrey900,
                  ),
                ),
              ),
              Gap(10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: "Dark Theme",
                    fontSize: 14.spMin,
                  ),
                  Gap(15.h),
                  TextView(
                    text: "Select the feel of your app",
                    color: themeMode == ThemeMode.light ? AppColors.kGrey500 : AppColors.kGrey400,
                  ),
                ],
              )
            ],
          ),
          ListenableBuilder(
              listenable: themeProvider,
              builder: (BuildContext context, Widget? child) {
                final themeMode = themeProvider.themeMode;

                return CupertinoSwitch(
                    value: themeMode == ThemeMode.light,
                    onChanged: (value) async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      if (value) {
                        themeProvider.setThemeMode(ThemeMode.light);
                        prefs.setBool('isDarkTheme', false);
                        return;
                      }
                      themeProvider.setThemeMode(ThemeMode.dark);
                      prefs.setBool('isDarkTheme', true);
                    },
                    activeColor: AppColors.kPrimary1);
              })
        ],
      ),
    );
  }
}

class SellBuyMore extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    
    var dashProvider = ref.watch(dashboardViewModel);
    return GestureDetector(
      onTap: (){
        if(id == more){
          dashProvider.setPageIndex(selectedPageIndex: 2);
        } else{
          if(id == sell){
            dashProvider.setPageIndex(selectedPageIndex: 1);
            dashProvider.setExchangePageIndex(selectedPageIndex: 1);
          } else {
            dashProvider.setPageIndex(selectedPageIndex: 1);
            dashProvider.setExchangePageIndex(selectedPageIndex: 0);
          }
        }
      },
      child: Column(
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
      ),
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
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h, top: 30.h),
      child: Container(
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
      ),
    );
  }
}
