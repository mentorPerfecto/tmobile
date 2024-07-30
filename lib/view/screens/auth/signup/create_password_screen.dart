import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/src/screens.dart';

class CreatePasswordScreen extends ConsumerStatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  ConsumerState<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends ConsumerState<CreatePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = ref.watch(registrationViewModel);
    var themeMode = ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
        arrowBackColor: theme.colorScheme.primary,
        bottomVisible: true,
        bottomText: createPassword,
      ),
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
                          
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: provider.registerationCreatePasswordFormKey,
                    child: PasswordValidatedFields(
                      textEditingController: provider.registerPwdController,
                      obscureInput: provider.obscurePasswordText,
                      confirmPasswordWidget: CustomTextField(
                        fieldLabel: confirmPassword,
                        hint: enterPassword,
                        controller: provider.registerConfirmPwdController,
                        password: true,
                        validator: (value) => Validators().validateConfirmPassword(
                          provider.registerPwdController.text,
                          provider.registerConfirmPwdController.text,
                        ),
                        obscureInput: provider.obscureConfirmPwdText,
                        onObscureText: provider.toggleConfirmPwdVisibility,
                        onChanged: (p0) => provider.updateRegisterButtonCreatePasswordState(),
                      ),
                      onObscureText: provider.togglePwdVisibility,
                    ),
                  ),
                ),
              ),
              DefaultButtonMain(
                  text: createAccount,
                  color: AppColors.kPrimary1,
                  buttonState: provider.buttonRegisterStateCreatePassword.buttonState,
                  onPressed: () {
                    navigatePush(context, VerifyAccountScreen());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
