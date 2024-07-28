import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';


class BVNVerificationScreen extends ConsumerWidget {
  BVNVerificationScreen({Key? key}) : super(key: key);
  final _bvnFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    var profileProvider = ref.watch(profileViewModel);
    var dashboardProvider = ref.watch(dashboardViewModel);
    return Scaffold(
      appBar: AppBars.mainAppBar(
        context,
        backgroundColor: theme.scaffoldBackgroundColor,
        arrowBackColor: theme.colorScheme.primary,
        text: verifyAccountTextInCaps,
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
                  const CustomTextField(
                    fieldLabel: verificationDocument,
                    hint: bankVerificationNumber,
                    readOnly: true,
                  ),
                  Gap(15.h),
                  Form(
                    key: _bvnFormKey,
                    child: CustomTextField(
                      keyboardType: TextInputType.number,
                      fieldLabel: bvnNumber,
                      hint: enterNumber,
                      controller: profileProvider.bvnNumberController,
                      onChanged: (bvn) => profileProvider.updateVerifyBVNButtonState(),
                      validator: (bvn) => Validators().validateBvn(bvn),
                    ),
                  ),
                  Gap(5.h),
                  TextView(
                    text: dialUSSDToSeeYourBVN,
                    fontSize: 14.sp,
                    color: AppColors.kGrey400,
                  )
                ],
              ),
              DefaultButtonMain(
                textColor: AppColors.kWhite,
                color: AppColors.kPrimary1,
                text: profileProvider.verifyBVNButtonState.text,
                buttonState: profileProvider.verifyBVNButtonState.buttonState,
                onPressed: () {
                  if (_bvnFormKey.currentState!.validate()) {
                    _bvnFormKey.currentState!.save();
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        barrierColor: AppColors.kTransparent,
                        context: context,
                        builder: (context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: TPayDefaultProgressStatusPopUp(
                              progressStatusLogo: AppImages.inProgressLogo,
                              progressStatusTextTitle: inProgress,
                              progressStatusTextBody: yourAccountVerificationIsUnderReview,
                              action: DefaultButtonMain(
                                textColor: AppColors.kWhite,
                                color: AppColors.kPrimary1,
                                text: backToHome,
                                onPressed: () {
                                  dashboardProvider.setPageIndexToHome(context);
                                },
                              ),
                            ),
                          );
                        });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
