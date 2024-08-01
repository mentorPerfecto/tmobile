import 'package:flutter/material.dart';
import 'package:tampay/model/local/dummy_data.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';

class WelcomeBackScreen extends StatelessWidget {
  const WelcomeBackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        backgroundColor: AppColors.kCharcoalBlack,
        body: Stack(children: [
          Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              bottom: 25.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Column(
                    children: [
                      const ProfileImage(imageType: ProfileImageType.user),
                      Gap(10.h),
                      TextView(
                        text: "Welcome Back, ${DummyData.firstName}",
                        textStyle: theme.textTheme.titleLarge,
                      ),
                      Gap(10.h),
                      TextView(
                        text: "use password",
                        textStyle: theme.textTheme.titleMedium,
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
                  onPressed: () {},
                )
              ],
            ),
          ),
          Column(
            children: [
              Positioned(
                top: -77.93,
                left: -44.21,
                child: Container(
                  width: 191.w,
                  height: 287.h,
                  decoration: const BoxDecoration(gradient: AppColors.kOceanBreezeGradient),
                ),
              ),
              Positioned(
                top: 254,
                left: 155.9,
                child: Container(
                  width: 191.w,
                  height: 287.h,
                  decoration: const BoxDecoration(gradient: AppColors.kSunriseHorizonGradient),
                ),
              )
            ],
          ),
        ]));
  }
}
