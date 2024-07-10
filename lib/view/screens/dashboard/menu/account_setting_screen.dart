import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/model/local/dummy_data.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:flutter/material.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';

class AccountSettingScreen extends ConsumerStatefulWidget {
  const AccountSettingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountSettingScreen> createState() =>
      AccountSettingScreenState();
}

class AccountSettingScreenState extends ConsumerState<AccountSettingScreen> {


  bool isContactDetailsVisible = false;

  @override

  void initState() {
    var userProfileProvider = ref.read(profileViewModel);
    //
    // if(userProfileProvider.gender!.toLowerCase() == 'null' ){
    //
    // }
    ///userProfileProvider.getGender(userProfileProvider.gender);
    isContactDetailsVisible = userProfileProvider.profileData!.showContactInfo!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProfileProvider = ref.watch(profileViewModel);
    var themeProvider = ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return userProfileProvider.isUpdatingUserProfile
        ? const SuccessLoadingScreen(informationText: '')
        : Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBars.mainAppBar(
              context,
              text: "Account",
              backgroundColor: theme.scaffoldBackgroundColor,
              arrowBackColor: theme.colorScheme.primary,
              trailing: Padding(
                padding: const EdgeInsets.all(17.0),
                child: GestureDetector(
                  onTap: () {
                    displayDeleteUserProfileConfirmationMessageAlert(
                      theme: theme,
                      themeMode: themeProvider,
                      isDismissible: true,
                      context,
                      'Confirmation Message',
                      onTap: () {
                        navigateBack(context);
                        displayValidatePasswordAlert(
                          context,
                          theme: theme,
                          themeMode: themeProvider,
                          actionText: deleteAccountText,
                          passwordController:
                              userProfileProvider.validatePasswordControllers,
                          obscureInput: userProfileProvider.validatePassword,
                          onTap: () {
                            if (userProfileProvider
                                    .validatePasswordControllers.text ==
                                DummyData.password) {
                              navigateBack(context);
                              userProfileProvider.deleteUserProfile(
                                context,
                              );
                            } else {
                              showToast(msg: incorrectPassword, isError: true);
                            }
                          },
                        );
                      },
                    );
                  },
                  child: const Icon(
                    CupertinoIcons.delete,
                    color: AppColors.kErrorPrimary,
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Visibility(
                      visible: userProfileProvider.showUploadIndicator,
                      child: LinearProgressIndicator(
                        // value: profileProvider.uploadProgress,
                        color: theme.colorScheme.primary,
                        backgroundColor: AppColors.kGrey600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        // vertical: 20.h,
                        horizontal: 20.w,
                      ),
                      child: SizedBox(
                        width: 360.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(20.h),
                            Align(
                              child: ProfileImage(
                                imageUrl: userProfileProvider
                                    .profileData!.profileImage
                                    .toString(),
                                imageType: ProfileImageType.user,
                                // editImage: true,
                                height: 100.h,
                                fontSize: 24.spMin,
                                width: 100.w,
                                // onEditImageTap: () {
                                //   userProfileProvider
                                //       .updateProfilePhoto(context);
                                // },
                              ),
                            ),
                            Gap(30.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: personalInformation,
                                  fontSize: 18.spMin,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: ttHoves,
                                ),
                                Gap(20.h),
                                CustomTextField(
                                  fieldLabel: '',
                                  hint: firstNameText,
                                  controller:
                                      userProfileProvider.firstNameController,
                                ),
                                Gap(5.h),
                                CustomTextField(
                                  fieldLabel: '',
                                  hint: lastNameText,
                                  controller:
                                      userProfileProvider.lastNameController,
                                ),
                                Gap(10.h),
                                CustomTextField(
                                  fieldLabel: '',
                                  hint: emailText,
                                  controller: userProfileProvider
                                      .emailAddressController,
                                  readOnly: true,
                                ),
                                Gap(10.h),
                                CustomTextField(
                                  fieldLabel: '',
                                  hint: phoneNumberText,
                                  controller:
                                      userProfileProvider.phoneNumberController,
                                  keyboardType: TextInputType.number,
                                ),
                                Gap(10.h),
                                GenderDropDownContainer(
                                  gender: userProfileProvider.gender ??
                                      userProfileProvider.profileData!.gender,
                                  genderType: userProfileProvider.genderType,
                                  onChange: (String? newGender) {
                                    userProfileProvider.getGender(newGender);
                                  },
                                ),
                                Gap(10.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextView(
                                      text: "View contact details",
                                      fontSize: 16.spMin,
                                      fontWeight: FontWeight.w500,
                                      onTap: () {
                                        setState(() {
                                          isContactDetailsVisible =
                                          !isContactDetailsVisible;
                                        });
                                      },
                                    ),
                                    // showContactInfo
                                    Switch.adaptive(value: isContactDetailsVisible, onChanged: (value) {
                                      setState(() {
                                        isContactDetailsVisible = value;
                                      });
                                    })
                                  ],
                                ),
                                tampayTenantIDDetails(
                                  contactImage: userProfileProvider
                                      .profileData!.profileImage
                                      .toString(),
                                  isContactDetailsVisible:
                                      isContactDetailsVisible,
                                  uniqueIdFrmtampay: userProfileProvider
                                      .profileData!.tampayId
                                      .toString(),
                                  onTap: () => userProfileProvider
                                      .copyToClipBoard(context,
                                          value: userProfileProvider
                                              .profileData!.tampayId
                                              .toString()),
                                  name:
                                      "${DummyData.firstName} ${DummyData.lastName}",
                                  email: userProfileProvider
                                      .emailAddressController.text,
                                ),
                                Gap(12.h),

                              ],
                            ),
                            Gap(
                              35.h,
                            ),
                            DefaultButtonMain(
                              onPressed: () {
                                userProfileProvider
                                    .updateUserProfile(context, isContactDetailsVisible)
                                    .then((value) =>
                                        userProfileProvider.loadData(context));
                              },
                              height: 48.h,
                              borderRadius: 40.r,
                              color: AppColors.kPrimary1,
                              text: updateChanges,
                              textColor: AppColors.kWhite,
                            ),

                            Gap(
                              20.h,
                            ),

                            // DefaultButtonMain(
                            //   color: AppColors.kErrorPrimary,
                            //   borderColor: AppColors.kErrorPrimary,
                            //   borderRadius: 38.r,
                            //   height: 48.h,
                            //   fontFamily: ttHoves,
                            //   fontSize: 16.spMin,
                            //   fontWeight: FontWeight.w500,
                            //   textColor: AppColors.kWhite,
                            //   text: deleteAccountText,
                            //   onPressed: () {
                            //     displayDeleteUserProfileConfirmationMessageAlert(
                            //       isDismissible: true,
                            //       context,
                            //       'Confirmation Message',
                            //       onTap: () {
                            //         navigateBack(context);
                            //         displayValidatePasswordAlert(
                            //           context,
                            //           actionText: deleteAccountText,
                            //           passwordController: userProfileProvider.validatePasswordControllers,
                            //           obscureInput: userProfileProvider.validatePassword,
                            //           onTap: () {
                            //             if (userProfileProvider.validatePasswordControllers.text ==
                            //                 DummyData.password) {
                            //               navigateBack(context);
                            //               userProfileProvider.deleteUserProfile(
                            //                 context,
                            //               );
                            //             } else {
                            //               showToast(msg: incorrectPassword, isError: true);
                            //             }
                            //           },
                            //         );
                            //       },
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class tampayTenantIDDetails extends StatelessWidget {
  const tampayTenantIDDetails({
    super.key,
    required this.uniqueIdFrmtampay,
    required this.name,
    required this.email,
    required this.onTap,
    required this.isContactDetailsVisible,
    this.contactImage,
  });

  final String uniqueIdFrmtampay;
  final String name;
  final String email;
  final VoidCallback onTap;
  final String? contactImage;
  final bool isContactDetailsVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isContactDetailsVisible,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20.h),
            TextView(
              text: tampayTenantIdHeading,
              fontSize: 18.spMin,
              fontWeight: FontWeight.w600,
              fontFamily: ttHoves,
            ),
            Gap(15.h),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 14.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.kBackground,
              ),
              child: Row(
                children: [
                  ProfileImage(
                    height: 100.h,
                    width: 100.w,
                    imageType: ProfileImageType.user,
                    imageUrl: contactImage ?? 'ded',
                  ),
                  Gap(15.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        text: name,
                        fontSize: 16.spMin,
                        fontWeight: FontWeight.w500,
                        fontFamily: ttHoves,
                        color: AppColors.kTextBlack,
                      ),
                      Gap(4.h),
                      TextView(
                        text: email,
                        color: AppColors.kSubText,
                        fontSize: 13.spMin,
                        fontWeight: FontWeight.w400,
                        fontFamily: ttHoves,
                      ),
                      Gap(
                        6.h,
                      ),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                                text: uniqueIDText,
                                style: TextStyle(
                                  fontSize: 13.spMin,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.kSubText,
                                  fontFamily: ttHoves,
                                ),
                                children: [
                                  TextSpan(
                                    text: uniqueIdFrmtampay,
                                    style: TextStyle(
                                      fontSize: 13.spMin,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.kTextBlack,
                                      fontFamily: ttHoves,
                                    ),
                                  )
                                ]),
                          ),
                          Gap(
                            5.w,
                          ),
                          // InkWell(
                          //   onTap: onTap,
                          //   child: Image.asset(
                          //     AppImages.copyTextIcon,
                          //     width: 16.w,
                          //     height: 16.h,
                          //   ),
                          // )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GenderDropDownContainer extends ConsumerWidget {
  const GenderDropDownContainer({
    super.key,
    required this.gender,
    required this.genderType,
    required this.onChange,
  });

  final String? gender;
  final List<String> genderType;
  final Function(String?) onChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeMode = ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return Container(
      width: 340.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(
          6.r,
        ),
        border: Border.all(
          width: 1.2.w,
          color: themeMode == ThemeMode.light
              ? AppColors.kDisabledButton
              : AppColors.kDarkSecondary,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 10.h,
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: theme.scaffoldBackgroundColor,
                isExpanded: true,
                hint: Text(
                  gender?.toLowerCase() == 'null' ?  "Select Gender" : gender.toString(),
                  style: TextStyle(
                      color: themeMode == ThemeMode.light
                          ? Colors.black
                          : AppColors.kDisabledButton),
                ),
               // value:  gender ?? "Select Gender",
                icon: Image.asset(
                  AppImages.dropDownIcon,
                  color: theme.colorScheme.primary,
                ),
                iconSize: 24,
                // elevation: 16,
                style: TextStyle(
                  color: themeMode == ThemeMode.light
                      ? Colors.black
                      : AppColors.kDisabledButton,
                ),
                onChanged: onChange,
                items: genderType.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: TextView(
                      text: value,
                      color: themeMode == ThemeMode.light
                          ? Colors.black
                          : AppColors.kDisabledButton,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
