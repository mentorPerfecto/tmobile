import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/src/providers.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final forgotPassFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double textFieldButtonWidth = (MediaQuery.sizeOf(context).width - 15);
    ref.watch(themeViewModel).themeMode;
    var provider = ref.watch(authViewModel);
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
        backgroundColor: theme.scaffoldBackgroundColor,
        arrowBackColor: theme.colorScheme.primary,
        text: resetPass,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 50.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const TextView(
                    textAlign: TextAlign.center,
                    text: pleaseEnterEmailAttachedToYouToResetMail,
                  ),
                  Gap(20.h),
                  Form(
                    key: forgotPassFormKey,
                    child: CustomTextField(
                      fieldLabel: emailText,
                      hint: hintEmail,
                      controller: provider.forgotPwdEmailController,
                      validator: (value) => Validators().validateEmail(value),
                      onChanged: (value) => provider.updatePassResetButtonState(),
                    ),
                  ),
                ],
              ),
              DefaultButtonMain(
                // padding: EdgeInsets.symmetric(
                //   vertical: 14.h,
                //   horizontal: 28.w,
                // ),
                text: resetPass,
                color: AppColors.kPrimary1,
                buttonState: provider.buttonForgotPWdState!.buttonState,
                onPressed: () {
                  if (forgotPassFormKey.currentState!.validate()) {
                    forgotPassFormKey.currentState!.save();
                    navigatePush(
                      context,
                      const EmailVerificationScreen(
                        email: hintEmail,
                        isForgotPassword: true,
                        isSignIn: false,
                        actionText: createAccount,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
