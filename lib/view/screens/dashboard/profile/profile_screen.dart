import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rebirth/rebirth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';




class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool isLogOutLoading = false;

  @override
  Widget build(BuildContext context) {
    var profileProvider = ref.watch(profileViewModel);

    return Scaffold(
      body: SafeArea(
        child: XResponsiveWrap.mobile(
          onRefresh: () => profileProvider.loadData(context),
          // loading: provider.isGettingPersonalListings,
          // loadFailed:  recycleProvider.recycleHistoryResponse!.data == [],
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(30),
                  const UserAccountDetails(
                    name: 'Daniel Mason',
                    profilePicture: null,
                    userName: '0xdaniel',
                  ),
                  moreSection(),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget moreSection() {
    var themeProvider = ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileItem(
              title: verifyAccount,
              subTitle: 'complete account verification',
              iconPath: AppImages.verifyAccountIcon,
              onTap: () {
                navigatePush(context, const VerifyAccountLevelScreen());
              },
            ),
            ProfileItem(
              title: bankDetails,
              subTitle: 'View your payout bank accounts',
              iconPath: AppImages.bankDetailsLogo,
              onTap: () {
                navigatePush(context, const AddBankScreen());
              },
            ),

            ProfileItem(
              title: "Referrals",
              subTitle: 'Earn commissions for inviting friends',
              iconPath: AppImages.securityLogo,
              onTap: () {
                // navigatePush(context, const CustomerSupportScreen());
              },
            ),

            ProfileItem(
              title: "Preference",
              subTitle: 'More Configuration options',
              iconPath: AppImages.faqsLogo,
              onTap: () {
                // navigatePush(context, const AppDetailsScreen());
              },
            ),

            ProfileItem(
              title: securityText,
              subTitle: 'Protect yourself from intruders',
              iconPath: AppImages.securityLogo,
              onTap: () {
                // navigatePush(context, const CustomerSupportScreen());
              },
            ),

            // divider(),
            ProfileItem(
              title: "Support Center",
              subTitle: "Reach out to support and FAQs",
              iconPath: AppImages.helpCenterLogo,
              onTap: () {
                // launchInURL(Uri.parse(ApiConstants().bunchPayWebUrl));
              },
            ),
            isLogOutLoading
                ? const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CircularProgressIndicator(
                        color: AppColors.kPrimary1,
                      ),
                    ))
                : ProfileItem(
                    title: logoutText,
                    iconPath: AppImages.logOutLogo, isLogout: true,
                    onTap: () async {

                      await showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          barrierColor: Colors.black38,
                          context: context,
                          builder: (context) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3 ),
                              child: TPayDefaultProgressStatusPopUp(
                                progressStatusLogo: AppImages.inviteYourFriendsLogo,
                                height: 300, progressStatusLogoColor: AppColors.kGrey,
                                progressStatusTextTitle: logoutText,
                                progressStatusTextBody: sureYouWntToLogout,
                                action: DefaultButtonMain(
                                  color: AppColors.kPrimary1,
                                  text: backToLogin, width: 150.w,
                                  onPressed: () async {
                                    navigateBack(context);
                                    setState(() {
                                      isLogOutLoading = true;
                                    });
                                    try {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.remove('Email');
                                      await prefs.remove('Password');
                                      await prefs.remove('accessToken');
                                      await prefs.remove('firstTimeOnApp');
                                      DummyData.firstName = '';
                                      DummyData.lastName = '';
                                      await Future.delayed(const Duration(seconds: 2));
                                      WidgetRebirth.createRebirth(context: context);
                                    } catch (e) {
                                      setState(() {
                                        isLogOutLoading = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                            );
                          });
                      // displayLogoutDialog(context,
                      //     theme: theme,
                      //     themeMode: themeProvider, onTap: () async {
                      //
                      // });
                    }, subTitle: '',
                  ),
            // const SettingsThemeItem(logo: AppImages.btcLogo, title: "Settings")
          ],
        )
      ],
    );
  }

}


class UserAccountDetails extends ConsumerWidget {
  const UserAccountDetails(
      {super.key,
      required this.name,
      required this.userName,
      required this.profilePicture});

  final String name;
  final String userName;

  final String? profilePicture;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeProvider = ref.watch(themeViewModel).themeMode;
    var dashViewModel = ref.watch(dashboardViewModel);
    return Padding(
      padding:  EdgeInsets.all(15.r),
      child: Container(
        width: 460.w,
        height: 200.h,
        decoration: BoxDecoration(
            color:  themeProvider ==ThemeMode.dark?
            AppColors.kOnyxBlack : AppColors.kLightSilver,
            borderRadius: BorderRadius.all(Radius.circular(24.r))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileImage(
              imageType: ProfileImageType.user,
              imageUrl: profilePicture,
              height: 60, width: 60,
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                  text: name,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                const Gap(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView(
                        text: "User ID: $userName",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: themeProvider ==ThemeMode.dark?
                        AppColors.kGrey300 : AppColors.kGrey700),
                    const Gap(5),
                    GestureDetector(
                      onTap: (){
                        dashViewModel.copyToClipboard(userName);
                      },
                        child: SizedBox( height:  25.spMin, child: Image.asset(AppImages.copyLogo,
                        color: themeProvider ==ThemeMode.dark?
                        AppColors.kGrey300 : AppColors.kGrey700,)))
                  ],
                ),
                const Gap(4),
                TextView(
                  text: "Edit Profile",
                  fontSize: 12.sp, color: AppColors.kPrimary1,
                  onTap: (){
                    navigatePush(context, const AccountSettingScreen());
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProfileItem extends ConsumerWidget {
   final String title;
   final String subTitle;
   final VoidCallback? onTap;
   final String iconPath;
   final bool isLogout;

  const ProfileItem({super.key, required this.title,
    this.isLogout = false,
    required this.subTitle,
    this.onTap, required this.iconPath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeProvider = ref.watch(themeViewModel).themeMode;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
              children: [
                Container(
                  decoration:  BoxDecoration(
                      shape: BoxShape.circle, color: isLogout ? AppColors.kError300 :
                  themeProvider ==ThemeMode.light?  AppColors.kPrimary1 : AppColors.kGrey300
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImageView.asset(
                        iconPath,
                        width: 20.w, color: isLogout ? AppColors.kWhite : themeProvider ==ThemeMode.dark?
                    AppColors.kBlack8 : AppColors.kWhite
                    ),
                  ),
                ),
                const Gap(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: title, fontSize: 14.spMin,
                      fontWeight: FontWeight.w400,
                      // color: AppColors.kErrorPrimary,
                    ),
                    isLogout ? const SizedBox.shrink() : const Gap(6),
                    isLogout ? const SizedBox.shrink() :  TextView(
                        text: subTitle, fontSize: 12.spMin,
                        color: AppColors.kGrey500
                    ),
                  ],
                ),
              ],
            ),
            Icon(
                Icons.arrow_forward_ios,
                size: 16.r,
                color: AppColors.kGrey500
            ),
          ],
        ),
      ),
    );
  }
}


// class SettingsThemeItem extends ConsumerStatefulWidget {
//   const SettingsThemeItem({
//     super.key,
//     required this.logo,
//     required this.title,
//     this.onTap,
//   });
//   final String title;
//   final String logo;
//
//   final VoidCallback? onTap;
//   @override
//   ConsumerState<SettingsThemeItem> createState() => _SettingsThemeItemState();
// }
//
// class _SettingsThemeItemState extends ConsumerState<SettingsThemeItem> {
//   @override
//   Widget build(BuildContext context) {
//     var themeProvider = ref.watch(themeViewModel);
//     return InkWell(
//       onTap: widget.onTap,
//       child: SizedBox(
//         height: 40.h,
//         // color: Colors.red,
//
//         width: double.infinity,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Image.asset(
//                   widget.logo,
//                   width: 24.w,
//                   height: 24.h,
//                   color: themeProvider.themeMode == ThemeMode.light
//                       ? AppColors.kIcon
//                       : AppColors.kPrimary150,
//                 ),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 TextView(
//                   onTap: widget.onTap,
//                   text: widget.title,
//                   fontSize: 16.spMin,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: soraFont,
//                   color: themeProvider.themeMode == ThemeMode.light
//                       ? AppColors.kTextBlack
//                       : AppColors.kWhite,
//                 )
//               ],
//             ),
//             ListenableBuilder(
//                 listenable: themeProvider,
//                 builder: (BuildContext context, Widget? child) {
//                   final themeMode = themeProvider.themeMode;
//
//                   return CupertinoSwitch(
//                     value: themeMode == ThemeMode.dark,
//                     onChanged: (value) async {
//                       SharedPreferences prefs =
//                       await SharedPreferences.getInstance();
//                       if (value) {
//                         themeProvider.setThemeMode(ThemeMode.dark);
//                         prefs.setBool('isDarkTheme', true);
//                         return;
//                       }
//                       themeProvider.setThemeMode(ThemeMode.light);
//                       prefs.setBool('isDarkTheme', false);
//                     },
//                     activeColor: themeMode == ThemeMode.light
//                         ? AppColors.kPrimary1
//                         : AppColors.kPrimary150,
//                   );
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }
