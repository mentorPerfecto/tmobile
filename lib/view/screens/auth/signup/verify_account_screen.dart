import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/screens/auth/signup/facial_verification_screen.dart';
import 'package:tampay/src/components.dart';

class VerifyAccountScreen extends ConsumerStatefulWidget {
  const VerifyAccountScreen({super.key});

  @override
  ConsumerState<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends ConsumerState<VerifyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var registrationProvider = ref.watch(registrationViewModel);
    var userProfileProvider = ref.watch(profileViewModel);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
   
        trailing: Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: InkWell(
            onTap: () {},
            child: TextView(
              text: skip,
              fontWeight: FontWeight.w600,
              fontSize: 14.spMin,
              color: theme.primaryColor,
            ),
          ),
        ),
        bottomVisible: true,
        bottomText: verifyAccount,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 650.h,
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
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      maxLength: 11,
                      fieldLabel: bvnNumber,
                      hint: enterNumber,
                      controller: registrationProvider.bvnNumberController,
                      onChanged: (bvn) => registrationProvider.updateVerifyBVNButtonState(),
                    ),
                    TextView(
                      text: registrationProvider.bvnDetails,
                      color: AppColors.kGrey500,
                      fontSize: 14.spMin,
                    ),
                    Gap(10.h),
                    CustomTextField(
                      fieldLabel: surname,
                      hint: enterSurname,
                      controller: registrationProvider.surnameController,
                      onChanged: (bvn) => registrationProvider.updateVerifyBVNButtonState(),
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
                        : const SizedBox.shrink()
                  ],
                ),
                Column(
                  children: [
                    DefaultButtonMain(
                      color: AppColors.kPrimary1,
                      text: next,
                      buttonState: registrationProvider.verifyBVNButtonState.buttonState,
                      onPressed: () {
                        navigatePush(context, const FacialVerificationScreen());
                      },
                    ),
                    Gap(40.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
