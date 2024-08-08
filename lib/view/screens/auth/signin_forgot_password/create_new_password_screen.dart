import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import '../../../../src/components.dart';
import '../../../../src/utils.dart';

class CreateNewPasswordScreen extends ConsumerStatefulWidget {
  const CreateNewPasswordScreen({super.key});

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
      appBar: AppBars.mainAppBar(
        context,

        bottomVisible: true,
        bottomText: createNewPassword,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
                        hint: enterPassword,
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
                Gap(40.h),
                DefaultButtonMain(
                  text: resetPass,
                  borderRadius: 8.r,
                  color: AppColors.kPrimary1,
                  buttonState: provider.buttonChangePwdState!.buttonState,
                  onPressed: () async {
                    await showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.black38,
                        context: context,
                        builder: (context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3 ),
                            child: TPayDefaultProgressStatusPopUp(
                              progressStatusLogo: AppImages.checkLogo,
                              height: 300,
                              progressStatusTextTitle: "Password Changed",
                              progressStatusTextBody:
                                  "You have successfully changed your password,\nplease login with the new password",
                              action: DefaultButtonMain(
                                color: AppColors.kPrimary1,
                                text: backToLogin, width: 150.w,
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SignInScreen()),
                                    (route) => false,
                                  );
                                },
                              ),
                            ),
                          );
                        });
                  },
                ),
                Gap(40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
