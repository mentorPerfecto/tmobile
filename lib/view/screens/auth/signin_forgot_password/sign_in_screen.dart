import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/view/screens/auth/signin_forgot_password/welcome_back_screen.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({
    super.key,
  });

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final loginFormKey = GlobalKey<FormState>();
  FocusNode passwordFocusNode = FocusNode();
  // bool isChecked = false;
  //Contains alreadyHaveAnAccount text widget
  youANewUser(ThemeData theme, ThemeMode themeMode) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: youreANewUser,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontSize: 12.spMin,
            fontFamily: soraFont,
            fontWeight: FontWeight.w400,

          ),
          children: <TextSpan>[
            TextSpan(
              text: signUp,
              style: TextStyle(
                color: AppColors.kPrimary1,
                fontSize: 12.spMin,
                fontWeight: FontWeight.w400,

              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => navigateReplace(
                      context,
                      const CreateAccountScreen(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = ref.watch(authViewModel);
    var themeMode = ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
         bottomVisible: true,
        bottomText: login

      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 15.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                    CustomTextField(
                      fieldLabel: emailText,
                      hint: hintEmail,
                      controller: provider.loginEmailController,
                      validator: (value) => Validators().validateEmail(value),
                      //onChanged: (value)=> provider.updateButtonState(),
                      onChanged: (p0) {
                        provider.updateButtonLoginState();
                      },
                    ),
                    Gap(15.h),
                    CustomTextField(
                      password: true,
                      obscureInput: provider.loginObscurePass,
                      onObscureText: provider.toggleLoginPwdVisibility,
                      fieldLabel: password,
                      hint: enterPassword,
                      controller: provider.loginPwdController,
                      validator: (value) => Validators().validateEmptyTextField(value),
                      //onChanged: (value)=> provider.updateButtonState(),
                      onChanged: (p0) {
                        provider.updateButtonLoginState();
                      },
                    ),
                    Gap(5.h),
                    TextView(
                      text: forgotPassword,
                      color: AppColors.kPrimary1,
                      onTap: () {
                        navigatePush(context, const ForgotPasswordScreen());
                      },
                    ),
                  ],
                ),
              ),
             Column(
               children: [
                 DefaultButtonMain(
                    text: login,
                   color: AppColors.kPrimary1,
                   buttonState: provider.buttonLoginState!.buttonState,
                   onPressed: () {
                     if (loginFormKey.currentState!.validate()) {
                       loginFormKey.currentState!.save();
                       navigatePush(
                         context,
                          const EmailVerificationScreen(
                           isSignIn: true,
                           isForgotPassword: false,
                           email: hintEmail,
                            actionText: verify,
                         ),
                       );
                     }
                   },
                 ),
                  const Gap(15),
                 youANewUser(theme, themeMode),
               ],
             )
            ],
          ),
        ),
      ),
    );
  }
}

