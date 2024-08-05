import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:flutter/material.dart';
import 'package:tampay/src/screens.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
   
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        child: SizedBox(
          width: 360.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: settings,
                fontSize: 22.spMin,
                fontWeight: FontWeight.w600,
                fontFamily: soraFont,
              ),
              Gap(
                20.h,
              ),
              GestureDetector(
                onTap: () {
                  navigatePush(context, const ChangePasswordScreen());
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Image.asset(
                          //   AppImages.securityPassword,
                          //   width: 19.w,
                          //   height: 20.h,
                          //   color: theme.indicatorColor,
                          // ),
                          Gap(5.w),
                          TextView(
                            text: changePassword,
                            fontSize: 16.spMin,
                            fontWeight: FontWeight.w500,
                            fontFamily: soraFont,
                          )
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 24.spMin,
                        color: theme.colorScheme.primary,
                      )
                    ],
                  ),
                ),
              ),
              Gap(
                20.h,
              ),
              // GestureDetector(
              //   onTap: () {
              //     // authProvider.resendOTP(context,
              //     //     email: DummyData.emailAddress.toString());
              //     trxProvider.transactionPinStatus?.data == true
              //         ? navigatePush(context, const EnterOtpScreen())
              //         : navigatePush(context, const CreatePinScreen());
              //   },
              //   child: SizedBox(
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           children: [
              //             Image.asset(
              //               AppImages.pinLock,
              //               width: 19.w,
              //               height: 20.h,
              //               color: theme.indicatorColor,
              //             ),
              //             Gap(5.w),
              //             TextView(
              //               text: trxProvider.transactionPinStatus?.data == true
              //                   ? resetPin
              //                   : setupPin,
              //               fontSize: 16.spMin,
              //               fontWeight: FontWeight.w500,
              //               fontFamily: soraFont,
              //             )
              //           ],
              //         ),
              //         Icon(
              //           Icons.arrow_forward_ios,
              //           size: 24.spMin,
              //           color: theme.colorScheme.primary,
              //         )
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
