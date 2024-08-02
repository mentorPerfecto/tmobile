import 'package:flutter/material.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';

class AccountVerifiedConfirmationScreen extends StatelessWidget {
  const AccountVerifiedConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
        isVisible: false,
        bottomText: "Account Verified",
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text:
                    "Your account has been verified and you will receive an email notification shortly",
                maxLines: 2,
                textStyle: theme.textTheme.titleMedium,
              ),
              Image.asset(
                AppImages.checkLogo,
                width: 120.w,
                height: 120.h,
                color: AppColors.kLimeGreen,
              ),
              DefaultButtonMain(
                color: AppColors.kPrimary1,
                text: done,
                onPressed: () {
                  navigateReplace(context, const DashBoardScreen());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
