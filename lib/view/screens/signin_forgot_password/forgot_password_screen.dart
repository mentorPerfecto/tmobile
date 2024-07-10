import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/src/providers.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
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
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 50.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: AppColors.kIconContainer,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Image.asset(
                    AppImages.passwordLogo,
                    height: 64.h,
                    width: 64.w,
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                height: 90.h,
                width: 310.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextView(
                      text: forgotUserPassword,
                      textStyle: theme.textTheme.titleLarge,
                    ),
                    TextView(
                      text: pleaseEnterEmail,
                      maxLines: 2,
                      textStyle: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Form(
                key: forgotPassFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      fieldLabel: '',
                      hint: emailAddressText,
                      controller: provider.forgotPwdEmailController,
                      validator: (value) =>
                          Validators().validateEmptyTextField(value),
                      // onChanged: (value)=> provider.updateButtonState(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              DefaultButtonMain(
                height: 48.h,
                width: textFieldButtonWidth.w,
                // padding: EdgeInsets.symmetric(
                //   vertical: 14.h,
                //   horizontal: 28.w,
                // ),
                text: resetPass,
                borderRadius: 40.r,
                color: AppColors.kPrimary1,
                buttonState: provider.buttonForgotPWdState!.buttonState,
                onPressed: () {
                  if (forgotPassFormKey.currentState!.validate()) {
                    forgotPassFormKey.currentState!.save();
                    provider.callForgotPwd(context);
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
