import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/screens/auth/auth_success_screen.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  final String email;

  final bool isForgotPassword;
  // final  VoidCallback? onPressed;

  const EmailVerificationScreen({super.key, required this.email, this.isForgotPassword = false});

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
    String timerText = secondsRemaining > 9 ? "$secondsRemaining" : "0$secondsRemaining";
    var authProvider = ref.watch(authViewModel);
    ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0.w,
            vertical: 30.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: "Verify Email",
                    textStyle: theme.textTheme.titleLarge,
                  ),
                  Gap(20.h),
                  Text.rich(
                    TextSpan(
                      text: "We've sent you an OTP code via Email. "
                          "Please enter 6-digit code sent to ",
                      style: theme.textTheme.titleMedium!.copyWith(color: AppColors.kTextWhite),
                      children: [
                        TextSpan(
                          text: widget.email,
                          style: TextStyle(
                            color: AppColors.kPrimary1,
                            fontSize: 15.sp,
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
                        TextView(
                          text: enterCode,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
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
                          hintCharacter: '-',
                          hintStyle: TextStyle(
                            color: theme.colorScheme.primary,
                            fontFamily: soraFont,
                          ),
                          onChanged: (value) => authProvider.updateVerifyButtonState(value),
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                              borderWidth: 1.r,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(6.r),
                              fieldHeight: 48.h,
                              fieldWidth: 48.w,
                              inactiveColor: AppColors.kWhite200,
                              // inactiveFillColor: AppColors.kWhite,
                              selectedFillColor: AppColors.kAshBlue,
                              activeColor: AppColors
                                  .kPrimary1, // The color of the border of the active PIN code cell (digit being currently entered).
                              activeFillColor: AppColors
                                  .kAshBlue, // The color to fill the background of the active PIN code cell.
                              selectedColor: AppColors
                                  .kPrimary1 // The color of the border of the selected PIN code cell.,

                              ),
                        ),
                      ],
                    ),
                  ),
                  Gap(20.h),
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
                          color: AppColors.kDefaultProfileBackground,
                        )
                ],
              ),
              DefaultButtonMain(
                text: createAccount,
                color: AppColors.kPrimary1,
                buttonState: authProvider.buttonVerifyState!.buttonState,
                onPressed: () {
                  if (pinFormKey.currentState!.validate()) {
                    pinFormKey.currentState!.save();
                    navigatePush(
                        context,
                        const AuthSuccessScreen(
                          infoText: successfulAccountCreation,
                          newPage: DashBoardScreen(),
                        ));
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