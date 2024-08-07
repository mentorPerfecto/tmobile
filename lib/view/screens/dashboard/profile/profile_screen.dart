import 'dart:ui';

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
          padding: EdgeInsets.symmetric(horizontal: 15.w),
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
    var themeMode = ref.watch(themeViewModel).themeMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListItems(
              title: accountUpgrade,
              subText: 'Complete account verification',
              icon: AppImages.userAcctIcon,
              onPressed: () {
                navigatePush(context, const VerifyAccountLevelScreen());
              },
            ),
            ListItems(
              title: bankDetails,
              subText: 'View your payout bank accounts',
              icon: AppImages.bankIcon,
              onPressed: () {
                navigatePush(context, const AddBankScreen());
              },
            ),

            ListItems(
              title: "Referrals",
              subText: 'Earn commissions for inviting friends',
              icon: AppImages.friendsIcon,
              onPressed: () {
                navigatePush(context, const ReferAndEarnScreen());
              },
            ),

            ListItems(
              title: "Preference",
              subText: 'More Configuration options',
              icon: AppImages.preferenceIcon,
              onPressed: () {
                navigatePush(context, const PreferencesScreen());
              },
            ),

            ListItems(
              title: securityText,
              subText: 'Protect yourself from intruders',
              icon: AppImages.securityIcon,
              onPressed: () {
                navigatePush(context, const ChangePasswordScreen());
              },
            ),

            // divider(),
            ListItems(
              title: "Support Center",
              subText: "Reach out to support and FAQs",
              icon: AppImages.supportIcon,
              onPressed: () {
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
                : ListItems(
                    title: logoutText,
                    icon: AppImages.logOutLogo, isLogout: true,
                    onPressed: () async {
                      await showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          barrierColor: Colors.black38,
                          context: context,
                          builder: (context) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3 ),
                              child: TPayDefaultProgressStatusPopUp(
                                progressStatusLogo: AppImages.infoIcon,
                                height: 300, progressStatusLogoColor: AppColors.kGrey,
                                progressStatusTextTitle: logoutText,
                                progressStatusTextBody: sureYouWntToLogout,
                                action: Row( mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DefaultButtonMain(
                                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                                      text: cancel,
                                      textColor: themeMode == ThemeMode.dark ? AppColors.kWhite : AppColors.kPrimary1,
                                      borderColor: themeMode == ThemeMode.dark ? AppColors.kWhite : AppColors.kPrimary1,
                                      onPressed: () {
                                        navigatePush(context, const SignInScreen());
                                      },
                                    ),
                                    Gap(10.w),
                                    DefaultButtonMain(
                                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                                      color: AppColors.kError300,
                                      text: logoutText,
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
                                  ],
                                ),
                              ),
                            );
                          });
                      // displayLogoutDialog(context,
                      //     theme: theme,
                      //     themeMode: themeProvider, onTap: () async {
                      //
                      // });
                    }, subText: '',
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
    return Container(
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
                      child: SizedBox(   width: 18.w,
                          height: 18.h, child: Image.asset(AppImages.copyIcon,
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
    );
  }
}
