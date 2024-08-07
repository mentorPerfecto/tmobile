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
   // var userProfileProvider = ref.read(profileViewModel);
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
                                          showSuffixIcon: true, trailing: Padding(
                                            padding:  EdgeInsets.all(8.r),
                                            child: Image.asset(AppImages.editTextLogo, height: 20,),
                                          ),
                                          controller: userProfileProvider.usernameController,
                                        ),
                                        const Gap(15),
                                        CustomTextField(
                                          fieldLabel: phoneNumberText,
                                          hint: hintPhoneNumber,
                                          maxLength: 10, showSuffixIcon: true, trailing: Padding(
                                            padding:  EdgeInsets.all(8.r),
                                            child: Image.asset(AppImages.editTextLogo, height: 20, ),
                                          ),
                                          prefixIcon:   Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox( width: 30, child: Padding(
                                              padding:  EdgeInsets.symmetric(vertical: 9.h),
                                              child: const TextView( text: "+234", color:  AppColors.kWhite,),
                                            )),
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
