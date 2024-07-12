import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/src/screens.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  //Contains alreadyHaveAnAccount text widget
  alreadyHaveAnAccount(ThemeData theme) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: haveAnAccount,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontSize: 16.spMin,
            fontFamily: soraFont,
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
      appBar: AppBars.mainAppBar(context,
          backgroundColor: theme.scaffoldBackgroundColor,
          arrowBackColor: theme.colorScheme.primary,
          text: createAccount),
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
                        fieldLabel: firstNameText,
                        hint: hintFirstName,
                        controller: provider.firstNameController,
                        validator: (value) => Validators().validateEmptyTextField(value),
                        onChanged: (p0) {
                          provider.updateRegisterButtonState();
                        },
                        //onChanged: (value)=> provider.updateButtonState(),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        fieldLabel: lastNameText,
                        hint: hintLastName,
                        controller: provider.lastNameController,
                        validator: (value) => Validators().validateEmptyTextField(value),
                        onChanged: (p0) {
                          provider.updateRegisterButtonState();
                        },
                        //onChanged: (value)=> provider.updateButtonState(),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        fieldLabel: emailText,
                        hint: hintEmail,
                        controller: provider.registerEmailController,
                        validator: (value) => Validators().validateEmail(value),
                        //onChanged: (value)=> provider.updateButtonState(),
                        onChanged: (p0) {
                          provider.updateRegisterButtonState();
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        fieldLabel: userName,
                        hint: hintUserName,
                        controller: provider.userNameController,
                        validator: (value) => Validators().validateUserName(value),
                        onChanged: (p0) {
                          provider.updateRegisterButtonState();
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        fieldLabel: phoneNumberText,
                        hint: hintPhoneNumber,
                        controller: provider.phoneNumberController,
                        validator: (value) => Validators().validatePhoneNumber(value),
                        onChanged: (p0) {
                          provider.updateRegisterButtonState();
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        borderWidth: 1.w,
                        fieldLabel: enterReferallCode,
                        hint: referralCode,
                        controller: provider.refCodeController,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                DefaultButtonMain(
                  text: continueText,
                  color: AppColors.kPrimary1,
                  buttonState: provider.buttonRegisterState.buttonState,
                  onPressed: () {
                    provider.userRegistration(context);
                  },
                ),
                SizedBox(
                  height: 10.h,
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
