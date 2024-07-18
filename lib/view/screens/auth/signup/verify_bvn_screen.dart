import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import '../../../../src/components.dart';

class VerifyBVNScreen extends ConsumerStatefulWidget {
  VerifyBVNScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<VerifyBVNScreen> createState() => _VerifyBVNScreenState();
}

class _VerifyBVNScreenState extends ConsumerState<VerifyBVNScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var registerationProvider = ref.watch(registrationViewModel);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(context,
          backgroundColor: theme.scaffoldBackgroundColor,
          arrowBackColor: theme.colorScheme.primary,
          text: verifyBVN),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 15.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextField(
                    fieldLabel: verificationMode,
                    hint: bankVerificationNumber,
                    readOnly: true,
                  ),
                  Gap(15.h),
                  CustomTextField(
                    fieldLabel: bvnNumber,
                    hint: enterBVN,
                    controller: registerationProvider.bvnNumberController,
                    onChanged: (bvn) => registerationProvider.updateVerifyBVNButtonState(),
                  ),
                  TextView(
                    text: dialUSSDToSeeYourBVN,
                    color: AppColors.kGrey100,
                    fontSize: 13.spMin,
                  ),
                ],
              ),
              Column(
                children: [
                  DefaultButtonMain(
                    textColor: AppColors.kWhite,
                    color: AppColors.kPrimary1,
                    text: registerationProvider.verifyBVNButtonState.text,
                    buttonState: registerationProvider.verifyBVNButtonState.buttonState,
                    onPressed: () {
                      navigatePush(context, const AddBankDetailsScreen());
                    },
                  ),
                  Gap(15.h),
                  DefaultButtonMain(
                    textColor: AppColors.kPrimary1,
                    color: AppColors.kTransparent,
                    text: skip,
                    onPressed: () {
                      navigateBack(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
