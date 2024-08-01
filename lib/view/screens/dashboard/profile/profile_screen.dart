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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  UserAccountDetails(
                    name: 'Daniel Mason',
                    profilePicture: null,
                    userName: '0xdaniel',
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  TampayDivider(),
                  SizedBox(
                    height: 12.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: InviteFriendCard(),
                  ),
                  SizedBox(
                    height: 10.h,
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
            // singleProfileOptions(
            //   title: referralsText,
            //   iconPath: AppImages.referralsIcon,
            //   onTap: () {},
            // ),
            // divider(),
            verifyAccountOptions(
              title: verifyAccount,
              iconPath: AppImages.verifyAccountIcon,
              onTap: () {
                navigatePush(context, const VerifyAccountLevelScreen());
              },
            ),
            singleProfileOptions(
              title: bankDetails,
              iconPath: AppImages.bankDetailsLogo,
              onTap: () {
                navigatePush(context, const AddBankScreen());
              },
            ),

            singleProfileOptions(
              title: securityText,
              iconPath: AppImages.securityLogo,
              onTap: () {
                // navigatePush(context, const CustomerSupportScreen());
              },
            ),
            singleProfileOptions(
              title: faqText,
              iconPath: AppImages.faqsLogo,
              onTap: () {
                // navigatePush(context, const AppDetailsScreen());
              },
            ),
            // divider(),
            singleProfileOptions(
              title: privacyPolicyText,
              iconPath: AppImages.privacyPolicyLogo,
              onTap: () {
                // launchInURL(Uri.parse(ApiConstants().bunchPayWebUrl));
              },
            ),
            singleProfileOptions(
              title: helpCenterText,
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
                : singleProfileOptions(
                    title: logoutText,
                    iconPath: AppImages.logOutLogo,
                    onTap: () async {
                      displayLogoutDialog(context,
                          theme: theme,
                          themeMode: themeProvider, onTap: () async {
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
                      });

                      // await Navigator.of(context).pushAndRemoveUntil(
                      //   // the new route
                      //   MaterialPageRoute(
                      //       builder: (BuildContext context) => const  LoginScreen()
                      //   ),
                      //       (Route route) => false,
                      // );
                    },
                  ),
            const SettingsThemeItem(logo: AppImages.btcLogo, title: "Settings")
          ],
        )
      ],
    );
  }

  Widget singleProfileOptions(
      {required String title,
      required VoidCallback onTap,
      Color? textColor,
      required String iconPath}) {
    // var paymentProvider = ref.watch(paymentViewModel);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageView.asset(
                  iconPath,
                  width: 20.w,
                ),
                SizedBox(
                  width: 8.w,
                ),
                TextView(
                  text: title,
                  fontWeight: FontWeight.w400,
                  color: textColor ?? Theme.of(context).colorScheme.primary,
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.r,
            )
          ],
        ),
      ),
    );
  }

  Widget verifyAccountOptions(
      {required String title,
      required VoidCallback onTap,
      Color? textColor,
      required String iconPath}) {
    // var paymentProvider = ref.watch(paymentViewModel);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageView.asset(
                  iconPath,
                  width: 20.w,
                ),
                SizedBox(
                  width: 8.w,
                ),
                TextView(
                  text: title,
                  fontWeight: FontWeight.w400,
                  color: textColor ?? Theme.of(context).colorScheme.primary,
                )
              ],
            ),
            Row(
              children: [
                const VerificationTextButton(
                  isProfileScreen: true,
                ),
                SizedBox(width: 25.w,),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.r,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: TampayDivider(),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CircleAvatar(
        //   radius: 24.r,
        //   backgroundImage: NetworkImage(profilePicture),
        // ),
        ProfileImage(
          imageType: ProfileImageType.user,
          imageUrl: profilePicture,
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextView(
              text: name,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 4.h,
            ),
            TextView(
                text: userName,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.kUnselectedBottomItemColor),
          ],
        )
      ],
    );
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
                    value: themeMode == ThemeMode.light,
                    onChanged: (value) async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      if (value) {
                        themeProvider.setThemeMode(ThemeMode.light);
                        prefs.setBool('isLightTheme', true);
                        return;
                      }
                      themeProvider.setThemeMode(ThemeMode.dark);
                      prefs.setBool('isLightTheme', false);
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
