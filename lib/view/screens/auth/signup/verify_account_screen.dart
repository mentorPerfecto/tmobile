import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import '../../../../src/components.dart';

class VerifyAccountScreen extends ConsumerStatefulWidget {
  VerifyAccountScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends ConsumerState<VerifyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var registerationProvider = ref.watch(registrationViewModel);
    var userProfileProvider = ref.watch(profileViewModel);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
        backgroundColor: theme.scaffoldBackgroundColor,
        arrowBackColor: theme.colorScheme.primary,
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
      ),
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
                  TextView(text: verifyAccount, textStyle: theme.textTheme.titleLarge),
                  Gap(15.h),
                  CustomTextField(
                    fieldLabel: surname,
                    hint: enterSurname,
                    controller: registerationProvider.surnameController,
                    onChanged: (bvn) => registerationProvider.updateVerifyBVNButtonState(),
                  ),
                  Gap(10.h),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    maxlength: 11,
                    fieldLabel: bvnNumber,
                    hint: enterNumber,
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
                          text: registerationProvider.bvnDetails,
                          color: AppColors.kGrey500,
                          fontSize: 14.spMin,
                        ),
                ],
              ),
              DefaultButtonMain(
                color: AppColors.kPrimary1,
                text: registerationProvider.verifyBVNButtonState.text,
                buttonState: registerationProvider.verifyBVNButtonState.buttonState,
                onPressed: () async {
                  await showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      barrierColor: AppColors.kTransparent,
                      context: context,
                      builder: (context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: TPayDefaultPopUp(
                            action: DefaultButtonMain(
                              color: AppColors.kPrimary1,
                              text: "Confirm",
                              onPressed: () {
                                navigatePush(context, const AddBankDetailsScreen());
                              },
                            ),
                          ),
                        );
                      });
                  // userProfileProvider.addUserAccountNumber(
                  //   context,
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
