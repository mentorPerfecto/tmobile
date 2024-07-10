import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  final String email;
  final String pwd;
  final String title;
  final String subTitle;
  final bool isForgotPassword;
  // final  VoidCallback? onPressed;

  const EmailVerificationScreen(
      {super.key,
      required this.email,
      required this.pwd,
      required this.title,
      required this.subTitle,
      this.isForgotPassword = false});

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  final pinFormKey = GlobalKey<FormState>();

  int secondsRemaining = 59;
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
      secondsRemaining = 59;
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    String timerText =
        secondsRemaining > 9 ? "00:$secondsRemaining" : "00:0$secondsRemaining";
    var authProvider = ref.watch(authViewModel);
    ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0.w,
            vertical: 40.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 160.h,
                width: 283.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                          color: AppColors.kIconContainer,
                          borderRadius: BorderRadius.circular(16.r)),
                      child: Center(
                        child: Image.asset(
                          AppImages.emailLogo,
                          height: 30.h,
                          width: 30.w,
                        ),
                      ),
                    ),
                    TextView(
                      text: widget.title,
                      textStyle: theme.textTheme.titleLarge,
                    ),
                    TextView(
                      text: widget.subTitle,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      textStyle: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Form(
                key: pinFormKey,
                child: PinCodeTextField(
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
                    fontFamily: ttHoves,
                  ),
                  onChanged: (value) =>
                      authProvider.updateVerifyButtonState(value),
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
              ),
              SizedBox(
                height: 30.h,
              ),
              DefaultButtonMain(
                height: 48.h,
                text: continueText,
                borderRadius: 40.r,
                color: AppColors.kPrimary1,
                buttonState: authProvider.buttonVerifyState!.buttonState,
                onPressed: () {
                  if (pinFormKey.currentState!.validate()) {
                    pinFormKey.currentState!.save();
                    authProvider.verifyFPwdEmail(context,
                        email: widget.email,
                        pwd: widget.pwd,
                        isForgotPassword: widget.isForgotPassword);
                  }
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              authProvider.isResendingOTP
                  ? const CircularProgressIndicator()
                  : Text.rich(
                      TextSpan(
                        text: resendCode,
                        style: TextStyle(
                          fontFamily: ttHoves,
                          fontSize: 16.spMin,
                          fontWeight: FontWeight.w400,
                          color: theme.colorScheme.primary,
                        ),
                        children: [
                          secondsRemaining > 0
                              ? TextSpan(
                                  text: timerText,
                                  style: TextStyle(
                                    color: AppColors.kPrimary1,
                                    fontSize: 16.spMin,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: ttHoves,
                                  ),
                                )
                              : TextSpan(
                                  text: resendOTP,
                                  style: TextStyle(
                                    color: AppColors.kPrimary1,
                                    fontSize: 16.spMin,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: ttHoves,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      authProvider
                                          .resendOTP(context,
                                              email: widget.email.toString())
                                          .then((value) {
                                        if (value == true) {
                                          resetTImer()
                                              .then((value) => startTimer());
                                        }
                                      });
                                    })
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
