import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import '../../../../src/components.dart';
import '../../../../src/utils.dart';

class CreateNewPasswordScreen extends ConsumerStatefulWidget {
  CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends ConsumerState<CreateNewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var provider = ref.watch(authViewModel);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(context,
          backgroundColor: theme.scaffoldBackgroundColor,
          arrowBackColor: theme.colorScheme.primary,
          text: createNewPassword),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 20.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: provider.resetPassFormKey,
                child: Form(
                  key: provider.changePasswordFormKey,
                  child: PasswordValidatedFields(
                    textEditingController: provider.newPasswordController,
                    obscureInput: provider.obscureNewPass,
                    confirmPasswordWidget: CustomTextField(
                      fieldLabel: confirmPassword,
                      controller: provider.confirmNewPasswordController,
                      password: true,
                      validator: (value) => Validators().validateConfirmPassword(
                        provider.newPasswordController.text,
                        provider.confirmNewPasswordController.text,
                      ),
                      obscureInput: provider.obscureConfirmPass,
                      onObscureText: provider.toggleConfirmPassVisibility,
                      onChanged: (p0) => provider.updateCreateNewPassButtonState(),
                    ),
                    onObscureText: provider.toggleNewPassVisibility,
                  ),
                ),
              ),
              DefaultButtonMain(
                text: resetPass,
                borderRadius: 8.r,
                color: AppColors.kPrimary1,
                buttonState: provider.buttonChangePwdState!.buttonState,
                onPressed: () {
                  showModalBottomSheet(backgroundColor: Colors.transparent,
                      barrierColor: AppColors.kTransparent,
                      context: context,
                      builder: (context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: const ResetPassPopUp(),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResetPassPopUp extends StatelessWidget {
  const ResetPassPopUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360.h,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            12.r,
          ),
          topRight: Radius.circular(
            12.r,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: 15.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              AppImages.successLogo,
              width: 72.w,
              height: 72.h,
            ),
            Column(
              children: [
                TextView(
                  text: successful,
                  fontSize: 16.spMin,
                  fontWeight: FontWeight.w600,
                ),
                Gap(15.h),
                TextView(
                  textAlign: TextAlign.center,
                  text: youHaveSuccessfullyChangedPWordLoginToAccount,
                  fontSize: 12.spMin,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            DefaultButtonMain(
              textColor: AppColors.kWhite,
              color: AppColors.kPrimary1,
              text: backToLogin,
              onPressed: () {
                navigatePush(context, const SignInScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}
