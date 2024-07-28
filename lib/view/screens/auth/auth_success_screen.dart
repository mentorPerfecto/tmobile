import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';

class AuthSuccessScreen extends ConsumerWidget {
  const AuthSuccessScreen({Key? key, required this.infoText, required this.newPage})
      : super(key: key);
  final String infoText;
  final Widget newPage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: wellDone,
                textStyle: theme.textTheme.titleLarge,
              ),
              Column(
                children: [
                  // Image.asset(
                  //   AppImages.onboardingUltimateCashBackgroundImage,
                  //   width: 200.w,
                  //   height: 200.h,
                  // ),
                  TextView(
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    text: infoText,
                    fontSize: 14.sp,
                  )
                ],
              ),
              DefaultButtonMain(
                borderColor: AppColors.kPrimary1,
                text: viewDashboard,
                textColor: AppColors.kPrimary1,
                // buttonState: provider.buttonRegisterState!.buttonState,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    // the new route
                    MaterialPageRoute(
                      builder: (BuildContext context) => newPage,
                    ),

                    // this function should return true when we're done removing routes
                    // but because we want to remove all other screens, we make it
                    // always return false
                    (Route route) => false,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
