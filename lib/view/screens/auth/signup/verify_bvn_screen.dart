import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
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
    var userProfileProvider = ref.watch(profileViewModel);
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
                  userProfileProvider.isLoadingVerifiedBanks
                      ? Column(
                    children: [
                      Gap(10.h),
                      Container(
                        // color: Colors.red,
                        // height: 50.h,
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: LoadingIndicator(
                            indicatorType: Indicator.ballGridPulse,
                            colors: const [
                              AppColors.kPrimary2,
                            ],
                            strokeWidth: 2,
                            backgroundColor: theme.scaffoldBackgroundColor,
                            pathBackgroundColor: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  )
                      : TextView(
                    text: dummyName,
                    color: AppColors.kDisabledButton,
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
                      navigateReplace(context, DashBoardScreen());
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
