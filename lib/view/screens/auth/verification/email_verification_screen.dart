import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  final String email;
  final String actionText;
  final bool isSignIn;
  final bool isForgotPassword;
  // final  VoidCallback? onPressed;

  const EmailVerificationScreen({
    super.key,
    required this.email,
    required this.isSignIn,
    required this.actionText,
    required this.isForgotPassword,
  });

  @override
  ConsumerState<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends ConsumerState<EmailVerificationScreen> {
  final pinFormKey = GlobalKey<FormState>();

  int secondsRemaining = 50;
  // int secondsRemaining = 10;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    ref.read(authViewModel).clearPinCodeAndResetVerifyButtonState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (secondsRemaining > 0) {
          setState(() {
            secondsRemaining--;
          });
        } else {
          timer.cancel();
        }
      },
    );
  }

  Future<void> resetTImer() async {
    setState(() {
      secondsRemaining = 50;
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = ref.watch(authViewModel);
    ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
        bottomText: verifyEmail,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0.w,
            vertical: 10.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text.rich(
                    TextSpan(
                      text: weHaveSentAnOTP,
                      style: theme.textTheme.titleMedium!.copyWith(
                      //  color: AppColors.kTextWhite,
                        fontSize: 12.sp,
                      ),
                      children: [
                        TextSpan(
                          text: widget.email,
                          style: const TextStyle(
                            color: AppColors.kPrimary1,
                            fontFamily: soraFont,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(25.h),
                  Form(
                    key: pinFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextView(
                          text: enterCode,
                          fontWeight: FontWeight.w400,
                        ),
                        Gap(10.h),
                        PinCodeTextField(
                          // obscureText: true,
                          animationDuration: const Duration(
                            milliseconds: 300,
                          ),
                          appContext: context,
                          length: 6,
                          //controller: authProvider.pinCodeController,
                          // hintCharacter: '-',
                          // hintStyle: TextStyle(
                          //   color: theme.colorScheme.primary,
                          //   fontFamily: soraFont,
                          // ),
                          onChanged: (value) => authProvider.updateVerifyButtonState(value),
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                              inactiveBorderWidth: 1.r,
                              activeBorderWidth: 1.r,
                              inactiveFillColor: AppColors.kOnyxBlack,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10.r),
                              fieldHeight: 48.h,
                              fieldWidth: 48.w,
                              inactiveColor: AppColors.kStormyGrey,
                              // inactiveFillColor: AppColors.kWhite,
                              selectedFillColor: AppColors.kOnyxBlack,
                              activeColor: AppColors .kPrimary1, // The color of the border of the active PIN code cell (digit being currently entered).
                              activeFillColor: AppColors .kOnyxBlack, // The color to fill the background of the active PIN code cell.
                              selectedColor: AppColors.kPrimary1 // The color of the border of the selected PIN code cell.,

                              ),
                        ),
                      ],
                    ),
                  ),
                  Gap(10.h),
                  secondsRemaining == 0
                      ? authProvider.isResendingOTP
                          ? const CircularProgressIndicator()
                          : TextView(
                              text: resendCode,
                              color: AppColors.kPrimary1,
                              onTap: () {
                                resetTImer();
                                startTimer();
                              },
                            )
                      : TextView(
                          text: "Resend Code in $secondsRemaining secs",
                          color: AppColors.kGrey400,
                        )
                ],
              ),
              Column(
                children: [
                  DefaultButtonMain(
                    text: widget.actionText,
                    color: AppColors.kPrimary1,
                    buttonState: authProvider.buttonVerifyState!.buttonState,
                    onPressed: () {
                      if (pinFormKey.currentState!.validate()) {
                        pinFormKey.currentState!.save();
                        navigatePush(
                          context,
                          widget.isForgotPassword
                              ? CreateNewPasswordScreen()
                              : widget.isSignIn
                                  ? AuthSuccessScreen(
                                      infoText:
                                          widget.isSignIn ? welcomeBack : successfulAccountCreation,
                                      newPage: const DashBoardScreen(),
                                    )
                                  : const CreatePasswordScreen(),
                        );
                      }
                    },
                  ),
                  Gap(40.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
