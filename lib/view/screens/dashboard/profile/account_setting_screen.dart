import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/model/local/dummy_data.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:flutter/material.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';

class AccountSettingScreen extends ConsumerStatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  ConsumerState<AccountSettingScreen> createState() =>
      AccountSettingScreenState();
}

class AccountSettingScreenState extends ConsumerState<AccountSettingScreen> {


 // bool isContactDetailsVisible = false;

  @override

  void initState() {
    var userProfileProvider = ref.read(profileViewModel);
    //
    // if(userProfileProvider.gender!.toLowerCase() == 'null' ){
    //
    // }
    ///userProfileProvider.getGender(userProfileProvider.gender);
  ///  isContactDetailsVisible = userProfileProvider.profileData!.showContactInfo!;
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
              bottomText: 'Edit Profile',
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
                  child: Image.asset(
                    AppImages.deleteLogo,
                    color: AppColors.kErrorPrimary,
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: SizedBox(

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
                            height: 675.h, 
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Gap(20.h),
                                    Align(
                                      child: ProfileImage(
                                        imageUrl: userProfileProvider
                                            .profileData?.profileImage
                                            .toString(),
                                        imageType: ProfileImageType.user,
                                         editImage: true,
                                        height: 100.h,
                                        fontSize: 24.spMin,
                                        width: 100.w,
                                        onEditImageTap: () {
                                          userProfileProvider
                                              .updateProfilePhoto(context);
                                        },
                                      ),
                                    ),
                                    Gap(30.h),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomTextField(
                                          fieldLabel: 'Full Name',
                                          hint: firstNameText, readOnly: true,
                                          controller: userProfileProvider.fullNameController,
                                        ),
                            
                                        const Gap(15),
                                        CustomTextField(
                                          fieldLabel: 'Email',
                                          hint: emailText,
                                          controller: userProfileProvider
                                              .emailAddressController,
                                          readOnly: true,
                                        ),
                                        const Gap(15),
                                        CustomTextField(
                                          fieldLabel: 'Birthday',
                                          hint: '09 Jun, 2024',  readOnly: true,
                                          controller: userProfileProvider.fullNameController,
                                        ),
                            
                                        const Gap(15),
                                        CustomTextField(
                                          fieldLabel: 'Username',
                                          hint: lastNameText,
                                          showSuffixIcon: true, trailing: const Icon(Icons.edit_note_outlined),
                                          controller: userProfileProvider.usernameController,
                                        ),
                                        const Gap(15),
                                        CustomTextField(
                                          fieldLabel: phoneNumberText,
                                          hint: hintPhoneNumber,
                                          maxLength: 10, showSuffixIcon: true, trailing: const Icon(Icons.edit_note_outlined),
                                          prefix: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextView( text: "+234",),
                                          ),
                                          controller: userProfileProvider.phoneNumberController,
                                          validator: (value) => Validators().validatePhoneNumber(value),
                                          onChanged: (p0) {
                                          /////  provider.updateRegisterButtonState();
                                          },
                                        ),
                                        const Gap(30),
                                      ],
                                    ),
                                  ],
                                ),
                                DefaultButtonMain(
                                  onPressed: () {
                                    // userProfileProvider
                                    //     .updateUserProfile(context)
                                    //     .then((value) =>
                                    //         userProfileProvider.loadData(context));
                                  },
                                  color: AppColors.kPrimary1,
                                  text: "Save",
                                  textColor: AppColors.kWhite,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
              fontFamily: soraFont,
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
                        fontFamily: soraFont,
                        color: AppColors.kTextBlack,
                      ),
                      Gap(4.h),
                      TextView(
                        text: email,
                        color: AppColors.kSubText,
                        fontSize: 13.spMin,
                        fontWeight: FontWeight.w400,
                        fontFamily: soraFont,
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
                                  fontFamily: soraFont,
                                ),
                                children: [
                                  TextSpan(
                                    text: uniqueIdFrmtampay,
                                    style: TextStyle(
                                      fontSize: 13.spMin,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.kTextBlack,
                                      fontFamily: soraFont,
                                    ),
                                  )
                                ]),
                          ),
                          Gap(
                            5.w,
                          ),
                          // GestureDetector(
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
