import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';

import 'package:tampay/view/screens/dashboard/exchange/exchange_screen.dart';
import 'package:tampay/view_model/dashboard/wallet_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

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
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    var walletProvider = ref.watch(walletViewModel);
    // var profileProvider = ref.watch(profileViewModel);
    // var dashProvider = ref.watch(dashboardViewModel);

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
          // const Gap(30),
          Container( height: 450.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36.r),
              color: AppColors.kCharcoalBlack,
            ),
            child: Stack(
              children: [
              MovingCircles( height: 460, borderRadius: BorderRadius.circular(36.r),),
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
                          GestureDetector(
                            onTap: (){
                              navigatePush(context, const NotificationScreen());
                            },
                            child: ImageView.asset(
                              AppImages.notificationIcon,
                              width: 32.w,
                              height: 32.h,
                            ),
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
                                text:"*******",
                                fontSize: 40.spMin,
                                fontWeight: FontWeight.w400,
                                color: AppColors.kWhite,
                              ),
                              Gap(10.w),
                              GestureDetector(
                                onTap: walletProvider.toggleWalletBal ,
                                child: walletProvider.showWalletBal  ? Image.asset(
                                  AppImages.eyeSlashIcon,
                                  color: AppColors.kWhite,
                                  width: 14.w,
                                ):  Icon(
                                  Icons.visibility_outlined,
                                  color: AppColors.kWhite,
                                  size: 14.spMin,
                                ),
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
                    icon: AppImages.arrowUpIcon,
                    backgroundColor: themeMode == ThemeMode.light
                        ? AppColors.kPalePeriwinkle
                        : AppColors.kCharcoalGray,
                    iconColor: theme.colorScheme.primary,
                  ),
                  const SellBuyMore(
                    id: buy,
                    icon: AppImages.arrowDownIcon,
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
               navigatePush(context, const ExchangeScreen());
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
      onTap: () async {
        if(id == more){
          await showModalBottomSheet(
          backgroundColor: Colors.transparent,
          barrierColor: Colors.black38,
          context: context,
          builder: (context) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: TPayDefaultPopUp(
                action: SizedBox( height: 400.h,
                  child: Column(
                   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ListItems(
                        icon: AppImages.zapLogo,
                        onPressed: () {
                          navigatePush(context, const ExchangeScreen());
                        },
                        subText: "See exciting trading rates",
                        title: "View Rate",
                      ),
                      ListItems(
                        icon: AppImages.friendsIcon,
                        onPressed: () {
                          navigatePush(context, const ReferAndEarnScreen());
                        },
                        subText: "Earn commission from referrals",
                        title: "Refer A Friend",
                      ),
                      ListItems(
                        icon: AppImages.bankIcon,
                        onPressed: () {
                          navigatePush(context, const BankListScreen());
                        },
                        subText: "View your payout bank accounts",
                        title: "Bank Details",
                      ),
                      ListItems(
                        icon: AppImages.moonIcon,
                        onPressed: () {},
                        subText:  "Select the feel of your app",
                        title: "Dark Theme",
                        isToggleChange: true,
                        isThemeChange: true,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });

        } else{
          if(id == sell){
            dashProvider.setExchangePageIndex(selectedPageIndex: 1);
            navigatePush(context, const ExchangeScreen());

          } else {
            dashProvider.setExchangePageIndex(selectedPageIndex: 0);
              navigatePush(context, const ExchangeScreen());

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
                width: 25.w,
                height: 25.h,
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
      child: GestureDetector(
        onTap: (){
          navigatePush(context, const VerifyAccountScreen( isAuth: false,));
        },
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
      ),
    );
  }
}
