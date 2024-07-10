// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rebirth/rebirth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampay/model/local/dummy_data.dart';
import 'package:tampay/repository/network/api_constants.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  @override
  void didChangeDependencies() {
    var profileProvider = ref.watch(profileViewModel);
    Future.microtask(() {
      // profileProvider.loadData(context).then((value) => ref
      //     .watch(walletViewModel)
      //     .getAcctBalance(userType: profileProvider.profileData?.role ?? 0));
    });
    super.didChangeDependencies();
  }

  bool isLogOutLoading = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = ((MediaQuery.sizeOf(context).width) - 20);
    var profileProvider = ref.watch(profileViewModel);
    ref.watch(dashboardViewModel);
    var themeProvider = ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return Scaffold(
        backgroundColor: AppColors.kTransparent,
        body: XResponsiveWrap.mobile(
            onRefresh: () async {
              await profileProvider.loadData(context);
            },
            backgroundColor: AppColors.kTransparent,
            //loadFailed: profileProvider.profileData != null,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: const tampayDivider(),
              ),
              // int.parse(profileProvider.profileData?.role.toString() ?? '0') > 1
              //     ? Padding(
              //         padding: EdgeInsets.symmetric(horizontal: 12.w),
              //         child: AccountVerification(screenWidth: screenWidth),
              //       )
              //     : Container(),
              // SizedBox(
              //   height: 18.h,
              // ),
              // Container(
              //   width: screenWidth,
              //   padding: EdgeInsets.symmetric(horizontal: 12.w),
              //   decoration: BoxDecoration(
              //     // color: themeProvider == ThemeMode.light ? AppColors.kBackground : theme.cardColor,
              //     borderRadius: BorderRadius.circular(16.r),
              //   ),
              //   child: const SettingsThemeItem(
              //     logo: AppImages.moonSetting,
              //     title: darkMode,

              //     // onTap: () {
              //     //   themeProvider.setThemeMode(ThemeMode.dark);
              //     // },
              //   ),
              // ),
              // SettingsItem(
              //   logo: AppImages.accountSetting,
              //   title: account,
              //   onTap: () {
              //     navigatePush(
              //         context, const AccountSettingScreen());
              //   },
              //   titleColor: themeProvider == ThemeMode.light
              //       ? AppColors.kTextBlack
              //       : AppColors.kWhite,
              //   logoColor: themeProvider == ThemeMode.light
              //       ? AppColors.kIcon
              //       : AppColors.kPrimary150,
              // ),
              // SettingsItem(
              //   logo: AppImages.faq,
              //   onTap: () {
              //     launchInURL(Uri.parse(ApiConstants().faqsUrl));
              //   },
              //   title: faq,
              //   titleColor: themeProvider == ThemeMode.light
              //       ? AppColors.kTextBlack
              //       : AppColors.kWhite,
              //   logoColor: themeProvider == ThemeMode.light
              //       ? AppColors.kIcon
              //       : AppColors.kPrimary150,
              // ),
              // SettingsItem(
              //   logo: AppImages.support,
              //   title: support,
              //   onTap: () async {
              //     final Uri params = Uri(
              //       scheme: 'mailto',
              //       path: ' support@gettampay.com ',
              //       query:
              //       'subject=App Feedback&body=App Version 1.0', //add subject and body here
              //     );
              //     var url = params.toString();
              //     launchInURL(Uri.parse(url));
              //   },
              //   titleColor: themeProvider == ThemeMode.light
              //       ? AppColors.kTextBlack
              //       : AppColors.kWhite,
              //   logoColor: themeProvider == ThemeMode.light
              //       ? AppColors.kIcon
              //       : AppColors.kPrimary150,
              // ),
              // SettingsItem(
              //   logo: AppImages.about,
              //   title: about,
              //   onTap: () {
              //     launchInURL(Uri.parse(ApiConstants().aboutUrl));
              //   },
              //   titleColor: themeProvider == ThemeMode.light
              //       ? AppColors.kTextBlack
              //       : AppColors.kWhite,
              //   logoColor: themeProvider == ThemeMode.light
              //       ? AppColors.kIcon
              //       : AppColors.kPrimary150,
              // ),

              // int.parse(profileProvider.profileData!.role.toString()) > 1
              //     ?
              Column(
                children: [
                  Container(
                    //height
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      // color:
                      //     themeProvider == ThemeMode.light ? AppColors.kBackground : theme.cardColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [],
                    ),
                  ),
                  // SizedBox(height: 18.h),
                ],
              ),

              isLogOutLoading
                  ? const Align(alignment: Alignment.center, child: CircularProgressIndicator())
                  : Container(
                      width: screenWidth,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        // color: themeProvider == ThemeMode.light
                        //     ? AppColors.kBackground
                        //     : theme.cardColor,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: SettingsItem(
                        onTap: () async {
                          displayLogoutDialog(context, theme: theme, themeMode: themeProvider,
                              onTap: () async {
                            navigateBack(context);
                            setState(() {
                              isLogOutLoading = true;
                            });
                            try {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.remove('Email');
                              await prefs.remove('Password');
                              await prefs.remove('accessToken');
                              DummyData.firstName = '';
                              DummyData.lastName = '';
                              await Future.delayed(const Duration(seconds: 2));
                              WidgetRebirth.createRebirth(context: context);
                            } catch (e) {
                              setState(() {
                                isLogOutLoading = false;
                              });
                            }
                          });

                          // showToast(msg: 'Please wait ', isError: false);
                        },
                        // logo: AppImages.logOutSetting,
                        logo: "",
                        title: logOut,
                        titleColor: AppColors.kLogOutText,
                      ),
                    ),
            ]));
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key,
      required this.logo,
      required this.title,
      this.titleColor,
      this.onTap,
      this.logoColor});
  final String title;
  final String logo;
  final Color? titleColor;
  final VoidCallback? onTap;
  final Color? logoColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: 40.h,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        // color: Colors.red,

        width: double.infinity,
        child: Row(
          children: [
            Image.asset(
              logo,
              width: 24.w,
              height: 24.h,
              color: logoColor,
            ),
            SizedBox(
              width: 10.w,
            ),
            TextView(
              onTap: onTap,
              text: title,
              fontSize: 16.spMin,
              fontWeight: FontWeight.w500,
              fontFamily: soraFont,
              color: titleColor,
            )
          ],
        ),
      ),
    );
  }
}

class SettingsThemeItem extends ConsumerStatefulWidget {
  const SettingsThemeItem({
    super.key,
    required this.logo,
    required this.title,
    this.onTap,
  });
  final String title;
  final String logo;

  final VoidCallback? onTap;
  @override
  ConsumerState<SettingsThemeItem> createState() => _SettingsThemeItemState();
}

class _SettingsThemeItemState extends ConsumerState<SettingsThemeItem> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(themeViewModel);
    return InkWell(
      onTap: widget.onTap,
      child: SizedBox(
        height: 40.h,
        // color: Colors.red,

        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  widget.logo,
                  width: 24.w,
                  height: 24.h,
                  color: themeProvider.themeMode == ThemeMode.light
                      ? AppColors.kIcon
                      : AppColors.kPrimary150,
                ),
                SizedBox(
                  width: 10.w,
                ),
                TextView(
                  onTap: widget.onTap,
                  text: widget.title,
                  fontSize: 16.spMin,
                  fontWeight: FontWeight.w500,
                  fontFamily: soraFont,
                  color: themeProvider.themeMode == ThemeMode.light
                      ? AppColors.kTextBlack
                      : AppColors.kWhite,
                )
              ],
            ),
            ListenableBuilder(
                listenable: themeProvider,
                builder: (BuildContext context, Widget? child) {
                  final themeMode = themeProvider.themeMode;

                  return CupertinoSwitch(
                    value: themeMode == ThemeMode.dark,
                    onChanged: (value) async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      if (value) {
                        themeProvider.setThemeMode(ThemeMode.dark);
                        prefs.setBool('isDarkTheme', true);
                        return;
                      }
                      themeProvider.setThemeMode(ThemeMode.light);
                      prefs.setBool('isDarkTheme', false);
                    },
                    activeColor:
                        themeMode == ThemeMode.light ? AppColors.kPrimary1 : AppColors.kPrimary150,
                  );
                })
          ],
        ),
      ),
    );
  }
}
