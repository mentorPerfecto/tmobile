import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rebirth/rebirth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/components/invite_friend_card.dart';
import 'package:tampay/view/screens/dashboard/profile/bank_details/add_bank_screen.dart';
import 'package:tampay/view_model/profile/profile_view_model.dart';
import 'package:tampay/view_model/theme_view_model.dart';

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
                // navigatePush(context, const InviteFriendScreen());
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                      color: const Color(0xFFCCFCD1),
                      borderRadius: BorderRadius.circular(4.r)),
                  child: Center(
                    child: TextView(
                      text: 'Level 2',
                      fontSize: 10.spMin,
                      color: const Color(0xFF009A47),
                    ),
                  ),
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
