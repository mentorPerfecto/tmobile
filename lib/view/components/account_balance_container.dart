import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/components/button.dart';
import 'package:tampay/view/components/custom_text.dart';
import 'package:tampay/view_model/theme_view_model.dart';

class AccountBalanceContainer extends ConsumerWidget {
  const AccountBalanceContainer({
    super.key,
    required this.screenWidth,
    required this.accountBalanceButtonWidth,
    required this.usersAccountBalance,
    required this.actionText,
    required this.onTap,
    this.role,
  });

  final double screenWidth;
  final double accountBalanceButtonWidth;
  final String usersAccountBalance;
  final String actionText;
  final VoidCallback onTap;
  final int? role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeMode = ref.watch(themeViewModel).themeMode;
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        // height: 110.h,
        width: screenWidth.w,
        decoration: BoxDecoration(
          color: AppColors.kCardAccount,
          borderRadius: BorderRadius.circular(
            12.r,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: totalPayout.toUpperCase(),
              fontFamily: soraFont,
              fontSize: 10.spMin,
              fontWeight: FontWeight.w400,
              color: AppColors.kCardText,
            ),
            SizedBox(
              height: 12.h,
            ),
            TextView(
              text: UtilFunctions.formatAmount(double.parse(usersAccountBalance.toString())),
              // text: ,
              fontSize: 21.spMin,
              fontWeight: FontWeight.w600,
              fontFamily: soraFont,
              color: AppColors.kWhite,
            ),
            TextView(
              text:
                  "~ ${UtilFunctions.currency(context)} ${UtilFunctions.formatAmount(double.parse(usersAccountBalance.toString()))}",
              // text: ,
              fontSize: 10.spMin,
              fontFamily: soraFont,
              color: AppColors.kUnselectedBottomItemColor,
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                defaultButton(
                  fontSize: 12.spMin, fontWeight: FontWeight.bold,
                  height: 44.h,
                  width: 138.w, //Adjust this width
                  text: buy,
                  imagePath: AppImages.receiveMoneyLogo,

                  color: AppColors.kBlueButton,
                  // buttonState: provider.buttonRegisterState!.buttonState,
                  // onPressed: onTap,
                  textColor: AppColors.kWhite,
                ),
                defaultButton(
                  fontSize: 12.spMin, fontWeight: FontWeight.bold,
                  height: 44.h,
                  width: 138.w, //Adjust this width
                  text: sell,
                  borderColor: AppColors.kBlueButton,

                  imagePath: AppImages.sendMoneyLogo,

                  color: Colors.transparent,
                  // buttonState: provider.buttonRegisterState!.buttonState,
                  // onPressed: onTap,
                  textColor: AppColors.kBlueButton,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget defaultButton({
     VoidCallback? onPressed,
     String? text,
     Color? color,
     Color? textColor,
     double? borderRadius,
     double? width,
     double? height,
     EdgeInsetsGeometry? padding,
     double? fontSize,
     FontWeight? fontWeight,
     Color? borderColor,
     String? fontFamily,
    String? imagePath,
}){
    return Container(
      height: height ?? 50.0.h,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
          color:color,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0.r),
          border: Border.all(color: borderColor ?? Colors.transparent)),
      child: ButtonTheme(
        child: MaterialButton(
          padding: EdgeInsets.zero,
          height: height ?? 50.0.h,

          onPressed:  onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                borderRadius ?? 8.0.r), // Adjust the radius as needed
          ),
          // disabledColor:(buttonState == ButtonState.disabled)?Colors.grey:null,
          child: Center(
            /// This code is setting the child of the `TextButton` widget. It checks the value of the
            /// `buttonState` parameter and if it is equal to `ButtonState.loading`, it sets the child to
            /// a `SizedBox` widget with a `CircularProgressIndicator` inside it. This is used to indicate
            /// that the button is in a loading state and the user should wait for the action to complete.
            /// If `buttonState` is not equal to `ButtonState.loading`, it sets the child to a `Text`
            /// widget with the `text` parameter passed in when the function is called. The `textColor`,
            /// `fontSize`, and `fontWeight` parameters are also used to style the text.
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageView.asset(imagePath, height: 20.h, width: 20.w,),
                SizedBox(width: 8.w,),
                Text(
                  text.toString(),
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: fontSize ?? 16.0.spMin,
                    fontWeight: fontWeight ?? FontWeight.w500,
                    fontFamily: fontFamily ?? soraFont,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ) ;
  }
}
