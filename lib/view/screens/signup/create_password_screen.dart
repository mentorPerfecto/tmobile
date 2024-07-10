import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/repository/network/api_constants.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/src/screens.dart';


class CreatePasswordScreen extends ConsumerStatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  ConsumerState<CreatePasswordScreen> createState() =>
      _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends ConsumerState<CreatePasswordScreen> {
  //Contains alreadyHaveAnAccount text widget
  alreadyHaveAnAccount(ThemeData theme) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: haveAnAccount,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontSize: 16.spMin,
            fontFamily: ttHoves,
            fontWeight: FontWeight.w400,
          ),
          children: <TextSpan>[
            TextSpan(
              text: signIn,
              style: TextStyle(
                color: AppColors.kPrimary1,
                fontSize: 16.spMin,
                fontWeight: FontWeight.w400,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => navigateReplace(
                  context,
                  const SignInScreen(
                    backBtnVisibility: true,
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = ref.watch(registrationViewModel);
    var themeMode = ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
          context,
          backgroundColor: theme.scaffoldBackgroundColor,
          arrowBackColor: theme.colorScheme.primary,
          text: createAccount
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 20.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: provider.registrationFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        fieldLabel: '',
                        hint: firstNameText,
                        controller: provider.firstNameController,
                        validator: (value) =>
                            Validators().validateEmptyTextField(value),

                        //onChanged: (value)=> provider.updateButtonState(),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        fieldLabel: '',
                        hint: lastNameText,
                        controller: provider.lastNameController,
                        validator: (value) =>
                            Validators().validateEmptyTextField(value),

                        //onChanged: (value)=> provider.updateButtonState(),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        fieldLabel: '',
                        hint: emailAddressText,
                        controller: provider.registerEmailController,
                        validator: (value) => Validators().validateEmail(value),

                        //onChanged: (value)=> provider.updateButtonState(),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        borderRadius: 6.r,
                        borderWidth: 1.w,
                        fieldLabel: "",
                        hint: referralCode,
                        controller: provider.refCodeController,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      PasswordValidatedFields(
                        textEditingController: provider.registerPwdController,
                        obscureInput: provider.obscurePasswordText,
                        confirmPasswordWidget: CustomTextField(
                          fieldLabel: '',
                          hint: confirmPassword,
                          controller: provider.registerConfirmPwdController,
                          password: true,
                          validator: (value) =>
                              Validators().validateConfirmPassword(
                                provider.registerPwdController.text,
                                provider.registerConfirmPwdController.text,
                              ),
                          obscureInput: provider.obscureConfirmPwdText,
                          onObscureText: provider.toggleConfirmPwdVisibility,
                        ),
                        onObscureText: provider.togglePwdVisibility,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: provider.toggleCheckerVisibility,
                            child: Container(
                              width: 18.w, // Adjust the size of the checkbox
                              height: 18.h, // Adjust the size of the checkbox
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    4.0.r), // Set the border radius
                                border: Border.all(
                                  color: provider.isChecked
                                      ? AppColors.kPrimary1
                                      : const Color(0xff979C9E), // Border color
                                  width: 1.5.w, // Border width
                                ),
                                color: provider.isChecked
                                    ? Colors.transparent
                                    : Colors
                                    .transparent, // Fill color when checked
                              ),
                              child: provider.isChecked
                                  ? Center(
                                child: Icon(
                                  Icons.check,
                                  size: 12.0.r,
                                  color: AppColors
                                      .kPrimary1, // Checkmark color
                                ),
                              )
                                  : null,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: agreeTo,
                                style: TextStyle(
                                    color: themeMode == ThemeMode.light
                                        ? AppColors.kNeutralBlack
                                        : AppColors.kWhite,
                                    fontSize: 14.spMin,
                                    fontFamily: ttHoves,
                                    fontWeight: FontWeight.w400),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: termsAndConditions,
                                      style: TextStyle(
                                        fontFamily: ttHoves,
                                        // decoration: TextDecoration.underline,
                                        color: themeMode == ThemeMode.light
                                            ? AppColors.kPrimary1
                                            : AppColors.kPrimary150,
                                        fontSize: 14.spMin,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          launchInURL(Uri.parse(ApiConstants()
                                              .termsOfSServicesUrl));
                                        }),
                                  const TextSpan(
                                    text: andThe,
                                  ),
                                  TextSpan(
                                      text: privacyPolicy,
                                      style: TextStyle(
                                        fontFamily: ttHoves,
                                        // decoration: TextDecoration.underline,
                                        color: themeMode == ThemeMode.light
                                            ? AppColors.kPrimary1
                                            : AppColors.kPrimary150,
                                        fontSize: 14.spMin,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          launchInURL(Uri.parse(
                                              ApiConstants().privacyPolicyUrl));
                                        }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                DefaultButtonMain(
                  height: 48.h,
                  width: 380.w,
                  text: createAccount,
                  borderRadius: 40.r,
                  color: AppColors.kPrimary1,
                  buttonState: provider.buttonRegisterState!.buttonState,
                  onPressed: () {
                    provider.userRegistration(context);
                  },
                ),
                SizedBox(
                  height: 40.h,
                ),
                alreadyHaveAnAccount(theme)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
