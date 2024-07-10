import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/src/providers.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  final resetPassFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = ref.watch(authViewModel);
    ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 40.h,
            horizontal: 15.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 79.h,
                width: 310.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      text: verifyEmail,
                      textStyle: theme.textTheme.titleLarge,
                    ),
                    TextView(
                      text: enterEmailCodeStart,
                      maxLines: 3,
                      textStyle: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0.h,
              ),
              Form(
                key: resetPassFormKey,
                child: PasswordValidatedFields(
                  textEditingController: provider.resetPwdController,
                  obscureInput: provider.obscureResetPass,
                  confirmPasswordWidget: CustomTextField(
                    fieldLabel: '',
                    hint: confirmPassword,
                    controller: provider.resetPwdConfirmController,
                    password: true,
                    validator: (value) => Validators().validateConfirmPassword(
                      provider.resetPwdController.text,
                      provider.resetPwdConfirmController.text,
                    ),
                    obscureInput: provider.obscureResetConfirmPass,
                    onObscureText: provider.toggleResetConfirmPwdVisibility,
                    maxLines: 1,
                  ),
                  onObscureText: provider.toggleResetPwdVisibility,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              DefaultButtonMain(
                height: 46.h, //fix the height bug.
                text: resetPass,
                borderRadius: 40.r,
                color: AppColors.kPrimary1,
                buttonState: provider.buttonResetPwdState!.buttonState,
                onPressed: () {
                  if (resetPassFormKey.currentState!.validate()) {
                    resetPassFormKey.currentState!.save();
                    provider.resetPwd(context);
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

// ignore: must_be_immutable
class EmailChecks extends StatelessWidget {
  EmailChecks({
    super.key,
    this.emailMustContain,
    this.color,
  });
  final String? emailMustContain;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20.h,
          width: 20.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              10.r,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.check,
              color: AppColors.kWhite,
              size: 15.spMin,
            ),
          ),
        ),
        SizedBox(
          width: 5.h,
        ),
        TextView(
          text: emailMustContain!,
          fontFamily: ttHoves,
          fontSize: 14.spMin,
          fontWeight: FontWeight.w400,
          color: AppColors.kSubText,
        )
      ],
    );
  }
}
