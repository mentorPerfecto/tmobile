import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:flutter/material.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/utils/validator.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  // void didChangeDependencies() {
  //   ref.watch(authViewModel).validateNewPassword();
  //   super.didChangeDependencies();
  // }

  @override
  void didChangeDependencies() {
    ref.watch(authViewModel).initPage();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var provider = ref.watch(authViewModel);
    ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
        backgroundColor: theme.scaffoldBackgroundColor,
        arrowBackColor: theme.colorScheme.primary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
          horizontal: 20.w,
        ),
        child: SizedBox(
          width: 360.w,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: changePassword,
                      fontSize: 22.spMin,
                      fontWeight: FontWeight.w600,
                      fontFamily: ttHoves,
                    ),
                    TextView(
                      text: enterYourOldPWordToChangePWord,
                      fontSize: 15.spMin,
                      fontWeight: FontWeight.w400,
                      color: theme.colorScheme.secondary,
                      fontFamily: ttHoves,
                    )
                  ],
                ),
                //change password validation, comes here.
                Gap(30.h),

                formField(),
                // Gap(8.h),
                // conditionList(),
                Gap(25.h),
                DefaultButtonMain(
                  onPressed: () {
                    if (provider.changePasswordFormKey.currentState!
                        .validate()) {
                      provider.changePasswordFormKey.currentState!.save();
                      provider.changePwd(context, setIndex: provider.role == 2 ? 3 : 4);
                    }
                  },
                  height: 48.h,
                  borderRadius: 40.r,
                  color: AppColors.kPrimary1,
                  text: changePassword,
                  textColor: AppColors.kWhite,
                  buttonState: provider.buttonChangePwdState!.buttonState,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  formField() {
    var provider = ref.watch(authViewModel);
    return Form(
      key: provider.changePasswordFormKey,
      child: Column(
        children: [
          CustomTextField(
            fieldLabel: '',
            hint: oldPassword,
            // focusNode: passwordFocusNode,
            password: true,
            validator: (value) => Validators().validatePassword(value),
            controller: provider.oldPasswordController,
            obscureInput: provider.obscureOldPass,
            onObscureText: provider.toggleOldPassVisibility,
            //onChanged: (value)=> provider.updateButtonState(),
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextField(
            fieldLabel: '',
            hint: newPassword,
            // focusNode: passwordFocusNode,
            password: true,
            validator: (value) => Validators().validatePassword(value),
            controller: provider.newPasswordController,
            obscureInput: provider.obscureNewPass,
            onObscureText: provider.toggleNewPassVisibility,
            //onChanged: (value)=> provider.updateButtonState(),
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextField(
            fieldLabel: '',
            hint: confirmPassword,
            // focusNode: passwordFocusNode,
            password: true,
            validator: (value) => Validators().validateConfirmPassword(
                value, provider.newPasswordController.text),
            controller: provider.confirmNewPasswordController,
            obscureInput: provider.obscureConfirmPass,
            onObscureText: provider.toggleConfirmPassVisibility,
            //onChanged: (value)=> provider.updateButtonState(),
          ),
        ],
      ),
    );
  }

  conditions({
    required var provider,
    required String text,
  }) {
    // provider = ref.watch(authViewModel);
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.check_circle,
              color: provider ? Colors.green : Colors.red,
            ),
            SizedBox(
              width: 5.w,
            ),
            TextView(
              text: text,
              fontSize: 12.spMin,
              fontWeight: FontWeight.w400,
              fontFamily: ttHoves,
            ),
          ],
        ),
      ],
    );
  }
}
