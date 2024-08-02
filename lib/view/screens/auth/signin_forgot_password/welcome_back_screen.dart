import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/model/local/dummy_data.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view_model/auth/local_auth_view_model.dart';


class WelcomeBackScreen extends ConsumerStatefulWidget {
  const WelcomeBackScreen({super.key});

  @override
  ConsumerState<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends ConsumerState<WelcomeBackScreen> {


  @override
  void initState() {
    super.initState();

    ref.read(localAuthViewModel).initLocalAuth();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var provider = ref.watch(localAuthViewModel);
    return Scaffold(
        backgroundColor: AppColors.kCharcoalBlack,
        body: Stack(children: [
          const MovingCircles(),
          Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              bottom: 25.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Gap(0),
                Center(
                  child: Column(
                    children: [
                      const ProfileImage(imageType: ProfileImageType.user, height: 100, width: 100,),
                      Gap(10.h),
                      TextView(
                        text: "Welcome Back, ${DummyData.firstName}",
                       // textStyle: theme.textTheme.titleLarge,
                        color: AppColors.kWhite,
                        fontSize: 24.spMin, fontWeight: FontWeight.w600,
                      ),
                      Gap(10.h),
                      TextView(
                        text: "Use password",
                     //   textStyle: theme.textTheme.titleMedium,
                        color: AppColors.kWhite,
                        fontSize: 12.spMin, fontWeight: FontWeight.w400,
                        onTap: () {
                          navigatePush(context, const SignInScreen());
                        },
                      ),
                    ],
                  ),
                ),
                DefaultButtonMain(
                  color: AppColors.kPrimary1,
                  text: "Use Biometrics",
                  buttonState: provider.isAuthenticating ? ButtonState.loading : ButtonState.idle ,
                  onPressed: () {
                    provider.authenticateWithBiometrics(context, mounted);
                  },
                )
              ],
            ),
          ),
        ]));
  }
}
