import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/src/providers.dart';

class EnterPinScreen extends ConsumerStatefulWidget {
  const EnterPinScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends ConsumerState<EnterPinScreen> {
  @override
  Widget build(BuildContext context) {
    ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
     
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: 20.h,
        ),
        child: SizedBox(
            width: 360.w,
            child: Column(
              children: [
                SizedBox(
                  height: 56.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextView(
                        text: enterPin,
                        fontSize: 22.spMin,
                        fontWeight: FontWeight.w600,
                        fontFamily: soraFont,
                      ),
                      TextView(
                        text: inputPinToContinue,
                        fontSize: 15.spMin,
                        fontWeight: FontWeight.w400,
                        fontFamily: soraFont,
                        color: theme.colorScheme.secondary,
                      )
                    ],
                  ),
                ),
                Gap(25.h),
                PinCodeTextField(
                  obscureText: true,
                  animationDuration: const Duration(
                    milliseconds: 300,
                  ),
                  appContext: context,
                  length: 6,
                  //controller: authProvider.pinCodeController,
                  hintCharacter: '-',
                  hintStyle: const TextStyle(
                    color: AppColors.kTextBlack,
                    fontFamily: soraFont,
                  ),

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
                      inactiveFillColor: AppColors.kWhite,
                      selectedFillColor: AppColors.kAshBlue,
                      activeColor: AppColors
                          .kPrimary1, // The color of the border of the active PIN code cell (digit being currently entered).
                      activeFillColor: AppColors
                          .kAshBlue, // The color to fill the background of the active PIN code cell.
                      selectedColor: AppColors
                          .kPrimary1 // The color of the border of the selected PIN code cell.,

                      ),
                ),
                Gap(20.h),
                TextView(
                  text: forgotPin,
                  fontSize: 15.spMin,
                  fontWeight: FontWeight.w500,
                  fontFamily: soraFont,
                  color: AppColors.kPrimary1,
                ),
                Gap(15.h),
                DefaultButtonMain(
                  onPressed: () {
                    //Success,then to the withdrawal bank screen.
                    navigatePush(
                        context,
                        const SuccessScreen(
                            infoText: yourBnkDetlsSved,
                            newPage: WithdrawalBankScreen(),
                            navigateButtonText: continueText));
                  },
                  height: 48.h,
                  borderRadius: 40.r,
                  color: AppColors.kPrimary1,
                  text: continueText,
                  textColor: AppColors.kWhite,
                ),
              ],
            )),
      ),
    );
  }
}
