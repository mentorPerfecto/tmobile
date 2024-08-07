import 'package:flutter/material.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/utils.dart';

import '../screens/dashboard/sell asset/sell_crypto_screen.dart';

class AUserBank extends StatelessWidget {
  const AUserBank({
    super.key,
    required this.themeMode,
  });

  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigatePush(context, const SellCryptoScreen());
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 12.w,
        ),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: themeMode == ThemeMode.light ? AppColors.kLightSilver : AppColors.kOnyxBlack,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ProfileImage(imageType: ProfileImageType.bank, imageUrl:   "https://images.app.goo.gl/9iBndnVeTkrVioMV6",
                  width: 30.w,
                  height: 30.h,),

                const TextView(
                  text: "Opay",
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextView(
                  text: "Obialor C Henry",
                  color: themeMode == ThemeMode.light ? AppColors.kGrey600 : AppColors.kGrey400,
                ),
                Gap(10.h),
                TextView(
                  text: "0550241576",
                  color: themeMode == ThemeMode.light ? AppColors.kGrey600 : AppColors.kGrey400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
