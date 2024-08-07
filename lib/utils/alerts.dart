import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';
import 'package:tampay/view/screens/dashboard/profile/bank_details/add_bank_screen.dart';

//1
Future<void> displayDeleteConfirmationMessageAlert(
  BuildContext context,
  String title, {
  required String message,
  required bool isDismissible,
  VoidCallback? onTap,
  required ThemeMode themeMode,
  required ThemeData theme,
  // btnOneText,
}) async {
  final width = MediaQuery.sizeOf(context).width;
  showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor:
              themeMode == ThemeMode.light ? AppColors.kWhite : theme.cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            height: 350.h,
            // height: deviceH / 3,
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextView(
                      text: title,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.spMin,
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    TextView(
                      text: message,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      fontSize: 16.spMin,
                    ),
                    SizedBox(
                      height: 26.h,
                    ),

                    DefaultButtonMain(
                      color: AppColors.kPrimary1,
                      width: 200.w,
                      text: continueText,
                      borderColor: AppColors.kPrimary1,
                      borderRadius: 38.r,
                      height: 48.h,
                      onPressed: onTap,
                    ),
                    // buttonConfirmation(
                    //     onPressed: () {
                    //       navigateBack(context);
                    //       navigatePush(context, EditAccountDetailsScreen());
                    //     },
                    //     text: continueText),
                    SizedBox(
                      height: 10.h,
                    ),

                    DefaultButtonMain(
                      width: 200.w,
                      text: back,
                      color: themeMode == ThemeMode.light
                          ? AppColors.kWhite
                          : theme.cardColor,
                      borderColor: theme.colorScheme.primary,
                      borderRadius: 38.r,
                      textColor: theme.colorScheme.primary,
                      height: 48.h,
                      onPressed: () {
                        navigateBack(context);
                      },
                    ),
                    // buttonConfirmation(
                    //     onPressed: () {
                    //       navigateBack(context);
                    //     },
                    //     text: back,
                    //     gradient: AppColors.white900Gradient,
                    //     textColor: Colors.black)
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

Future<void> displayFreezingListingConfirmationMessage(
  BuildContext context,
  String title, {
  required String message,
  required bool isDismissible,
  VoidCallback? onTap,
  required ThemeMode themeMode,
  required ThemeData theme,
  // btnOneText,
}) async {
  final width = MediaQuery.sizeOf(context).width;
  showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor:
              themeMode == ThemeMode.light ? AppColors.kWhite : theme.cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            // height: deviceH / 3,
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //   width: 48.w,
                    //   height: 48.h,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(28.r),
                    //     color: AppColors.kEnabledButton,
                    //   ),
                    //   child: Center(
                    //     child: Image.asset(
                    //       AppImages.freezingListingIcon,
                    //     ),
                    //   ),
                    // ),
                    Gap(20.h),
                    TextView(
                      text: title,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.spMin,
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    TextView(
                      text: message,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      fontSize: 16.spMin,
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Row(
                      children: [
                        DefaultButtonMain(
                          color: theme.scaffoldBackgroundColor,
                          text: "Cancel",
                          borderColor: AppColors.kGrey300,
                          textColor: theme.colorScheme.primary,
                          borderRadius: 8.r,
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 12.w,
                          ),
                          onPressed: () {
                            navigateBack(context);
                          },
                        ),
                        SizedBox(
                          width: 15.h,
                        ),
                        DefaultButtonMain(
                          text: "Continue",
                          color: themeMode == ThemeMode.light
                              ? AppColors.kPrimary1
                              : AppColors.kPrimary1Dark,
                          borderRadius: 8.r,
                          textColor: theme.scaffoldBackgroundColor,
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 12.w,
                          ),
                          onPressed: () {
                            navigateBack(context);
                            onTap!();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

//2
Future<void> displayDeleteUserProfileConfirmationMessageAlert(
  BuildContext context,
  String title, {
  required bool isDismissible,
  VoidCallback? onTap,
  required ThemeData theme,
  required ThemeMode themeMode,
  // btnOneText,
}) async {
  final width = MediaQuery.sizeOf(context).width;
  final deviceH = MediaQuery.sizeOf(context).height;
  showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor:
              themeMode == ThemeMode.dark ? theme.cardColor : AppColors.kWhite,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            height: (deviceH / 1.65).h,
            //height: getAlertDialogHeight(),
            // height: deviceH / 3,
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextView(
                      text: title,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.spMin,
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextView(
                          text: deleteAccntText,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.spMin,
                          maxLines: 3,
                          fontFamily: soraFont,
                        ),
                        SizedBox(height: 16.0.h),
                        TextView(
                          text: deleteAccntConsequenceText,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.spMin,
                          maxLines: 3,
                          fontFamily: soraFont,
                        ),
                        SizedBox(height: 8.0.h),
                        TextView(
                          text: lossOfAccntData,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.spMin,
                          maxLines: 3,
                          fontFamily: soraFont,
                        ),
                        TextView(
                          text: inabilityToRecoverAccntInformation,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.spMin,
                          maxLines: 3,
                          fontFamily: soraFont,
                        ),
                        SizedBox(height: 16.0.h),
                        TextView(
                          text: ireversibleActionText,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.spMin,
                          maxLines: 4,
                          fontFamily: soraFont,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 26.h,
                    ),

                    DefaultButtonMain(
                      color: AppColors.kPrimary1,
                      width: 200.w,
                      text: continueText,
                      borderColor: AppColors.kPrimary1,
                      borderRadius: 38.r,
                      height: 48.h,
                      onPressed: onTap,
                    ),
                    // buttonConfirmation(
                    //     onPressed: () {
                    //       navigateBack(context);
                    //       navigatePush(context, EditAccountDetailsScreen());
                    //     },
                    //     text: continueText),
                    SizedBox(
                      height: 10.h,
                    ),

                    DefaultButtonMain(
                      width: 200.w,
                      text: back,
                      color: themeMode == ThemeMode.light
                          ? AppColors.kWhite
                          : theme.cardColor,
                      borderColor: theme.colorScheme.primary,
                      borderRadius: 38.r,
                      textColor: theme.colorScheme.primary,
                      height: 48.h,
                      onPressed: () {
                        navigateBack(context);
                      },
                    ),
                    // buttonConfirmation(
                    //     onPressed: () {
                    //       navigateBack(context);
                    //     },
                    //     text: back,
                    //     gradient: AppColors.white900Gradient,
                    //     textColor: Colors.black)
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

//3
Future<void> displayValidatePasswordAlert(
  BuildContext context, {
  required VoidCallback onTap,
  required TextEditingController passwordController,
  required bool obscureInput,
  required String actionText,
  final void Function()? onObscureText,
  required ThemeMode themeMode,
  required ThemeData theme,
}) async {
  final width = MediaQuery.of(context).size.width;
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor:
            themeMode == ThemeMode.light ? Colors.white : theme.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          height: 320.h,
          width: width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.w),
            child: Column(
              children: [
                TextView(
                  text: enterPwd,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.spMin,
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextField(
                  fieldLabel: '',
                  hint: password,
                  password: true,
                  validator: (value) =>
                      Validators().validateEmptyTextField(value),
                  controller: passwordController,
                  obscureInput: obscureInput,
                  showSuffixIcon: false,
                  onObscureText: onObscureText,
                ),
                SizedBox(
                  height: 26.h,
                ),
                DefaultButtonMain(
                  color: AppColors.kErrorPrimary,
                  width: 200.w,
                  text: actionText,
                  borderColor: AppColors.kErrorPrimary,
                  borderRadius: 38.r,
                  height: 48.h,
                  onPressed: onTap,
                ),
                SizedBox(
                  height: 10.h,
                ),
                DefaultButtonMain(
                  width: 200.w,
                  text: cancel,
                  color: themeMode == ThemeMode.light
                      ? AppColors.kWhite
                      : theme.cardColor,
                  borderColor: theme.colorScheme.primary,
                  borderRadius: 38.r,
                  textColor: theme.colorScheme.primary,
                  height: 48.h,
                  onPressed: () {
                    navigateBack(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

//4
Future<void> displayRentConfirmationMessageAlert(
  BuildContext context,
  String title, {
  required String message,
  required bool isDismissible,
  VoidCallback? onTap,
  required ThemeMode themeMode,
  required ThemeData theme,
  // btnOneText,
}) async {
  final width = MediaQuery.sizeOf(context).width;
  showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor:
              themeMode == ThemeMode.light ? Colors.white : theme.cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            // height: 350.h,
            // height: deviceH / 3,
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextView(
                      text: title,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.spMin,
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    RichText(
                      text: TextSpan(
                        text: willingToPayText,
                        style: TextStyle(
                            color: themeMode == ThemeMode.light
                                ? Colors.black
                                : AppColors.kWhite,
                            fontSize: 16.spMin,
                            fontFamily: soraFont,
                            fontWeight: FontWeight.w400),
                        children: <TextSpan>[
                          TextSpan(
                            text: message,
                            style: TextStyle(
                                fontSize: 16.spMin,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // TextView(
                    //   text: message,
                    //   fontWeight: FontWeight.w400,
                    //   textAlign: TextAlign.center,
                    //   maxLines: 5,
                    //   fontSize: 16.spMin,
                    // ),
                    SizedBox(
                      height: 26.h,
                    ),

                    DefaultButtonMain(
                      color: AppColors.kPrimary1,
                      width: 200.w,
                      text: continueText,
                      borderColor: AppColors.kPrimary1,
                      borderRadius: 38.r,
                      height: 48.h,
                      onPressed: onTap,
                    ),
                    // buttonConfirmation(
                    //     onPressed: () {
                    //       navigateBack(context);
                    //       navigatePush(context, EditAccountDetailsScreen());
                    //     },
                    //     text: continueText),
                    SizedBox(
                      height: 10.h,
                    ),

                    DefaultButtonMain(
                      width: 200.w,
                      text: back,
                      color: themeMode == ThemeMode.light
                          ? AppColors.kWhite
                          : theme.cardColor,
                      borderColor: theme.colorScheme.primary,
                      borderRadius: 38.r,
                      textColor: theme.colorScheme.primary,
                      height: 48.h,
                      onPressed: () {
                        navigateBack(context);
                      },
                    ),
                    // buttonConfirmation(
                    //     onPressed: () {
                    //       navigateBack(context);
                    //     },
                    //     text: back,
                    //     gradient: AppColors.white900Gradient,
                    //     textColor: Colors.black)
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

Future<void> displayUnverifiedPropertyWarningAlert(
  BuildContext context, {
  VoidCallback? onTap,
  required ThemeMode themeMode,
  required ThemeData theme,
  // btnOneText,
}) async {
  final width = MediaQuery.sizeOf(context).width;
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor:
              themeMode == ThemeMode.light ? Colors.white : theme.cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            // height: deviceH / 3,
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Image.asset(
                    //   AppImages.warningIcon,
                    //   width: 64.w,
                    //   height: 64.h,
                    // ),
                    Gap(20.h),
                    Column(
                      children: [
                        TextView(
                          text: warningText,
                          fontSize: 22.spMin,
                          fontWeight: FontWeight.w600,
                          fontFamily: soraFont,
                        ),
                        Gap(10.h),
                        TextView(
                          text: unverifiedPrprty,
                          fontSize: 15.spMin,
                          fontWeight: FontWeight.w400,
                          fontFamily: soraFont,
                          color: AppColors.kSubText,
                        ),
                      ],
                    ),
                    Gap(15.h),
                    DefaultButtonMain(
                      color: themeMode == ThemeMode.light
                          ? AppColors.kPrimary1
                          : AppColors.kPrimaryDark,
                      width: 360.w,
                      textColor: themeMode == ThemeMode.light
                          ? AppColors.kWhite
                          : AppColors.kTextBlack,
                      text: continueText,
                      borderRadius: 40.r,
                      height: 48.h,
                      onPressed: onTap,
                    ),
                    Gap(10.h),
                    DefaultButtonMain(
                      color: theme.scaffoldBackgroundColor,
                      width: 360.w,
                      textColor: themeMode == ThemeMode.light
                          ? AppColors.kTextBlack
                          : AppColors.kPrimaryDark,
                      text: close,
                      borderRadius: 40.r,
                      borderColor: themeMode == ThemeMode.light
                          ? AppColors.kTextBlack
                          : AppColors.kPrimaryDark,
                      height: 48.h,
                      onPressed: () {
                        navigateBack(context);
                      },
                    ),
                    // buttonConfirmation(
                    //     onPressed: () {
                    //       navigateBack(context);
                    //     },
                    //     text: back,
                    //     gradient: AppColors.white900Gradient,
                    //     textColor: Colors.black)
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

//5
Future<dynamic> displayExitDialog(
  BuildContext context, {
  required ThemeMode themeMode,
  required ThemeData theme,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        backgroundColor:
            themeMode == ThemeMode.light ? Colors.white : theme.cardColor,
        title: Center(
          child: TextView(
            text: exitApp,
            fontSize: 16.spMin,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: TextView(
          text: sureYouWntToExtApp,
          fontSize: 14.spMin,
          maxLines: 2,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w500,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DefaultButtonMain(
                  color: Colors.white,
                  width: 120.w,
                  textColor: AppColors.kPrimary1,
                  text: no,
                  borderColor: AppColors.kPrimary1,
                  borderRadius: 38.r,
                  height: 48.h,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                child: DefaultButtonMain(
                  color: AppColors.kPrimary1,
                  width: 120.w,
                  text: yes,
                  borderColor: AppColors.kPrimary1,
                  borderRadius: 38.r,
                  height: 48.h,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}

//6
Future<dynamic> addPhotosFromCameraOrGalleryDialog(
  BuildContext context, {
  required VoidCallback cameraOnTap,
  required VoidCallback galleryOnTap,
  required ThemeMode themeMode,
  required ThemeData theme,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        backgroundColor:
            themeMode == ThemeMode.light ? Colors.white : theme.cardColor,
        // title: Center(
        //   child: TextView(
        //     text: 'Exit App',
        //     fontSize: 16.spMin,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        content: SizedBox(
          height: 100.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextView(
                text: addPhotosFrm,
                fontSize: 18.spMin,
                fontWeight: FontWeight.w500,
              ),
              Gap(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: galleryOnTap,
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 24.spMin,
                          color: themeMode == ThemeMode.light
                              ? AppColors.kPrimary1
                              : AppColors.kPrimary150,
                        ),
                        const Gap(5),
                        TextView(
                          text: gallery,
                          fontSize: 15.spMin,
                          fontWeight: FontWeight.w400,
                          fontFamily: soraFont,
                        ),
                      ],
                    ),
                  ),
                  const Gap(15),
                  GestureDetector(
                    onTap: cameraOnTap,
                    child: Column(
                      children: [
                        Icon(
                          Icons.photo_camera,
                          size: 24.spMin,
                          color: themeMode == ThemeMode.light
                              ? AppColors.kPrimary1
                              : AppColors.kPrimary150,
                        ),
                        const Gap(5),
                        TextView(
                          text: camera,
                          fontSize: 15.spMin,
                          fontWeight: FontWeight.w400,
                          fontFamily: soraFont,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

// //7
// Future<dynamic> displayUnverifiedPropertyDialog(
//   BuildContext context, {
//   required ThemeMode themeMode,
//   required ThemeData theme,
// }) async {
//   return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
//         backgroundColor:
//             themeMode == ThemeMode.light ? Colors.white : theme.cardColor,
//         // title: Center(
//         //   child: TextView(
//         //     text: 'Exit App',
//         //     fontSize: 16.spMin,
//         //     fontWeight: FontWeight.w600,
//         //   ),
//         // ),
//         content: TextView(
//           text: unverifiedPrprtsCnntBeVwd,
//           fontSize: 12.spMin,
//           fontWeight: FontWeight.w500,
//         ),
//         actions: <Widget>[
//           SizedBox(
//             width: 5.w,
//           ),
//           Center(
//             child: DefaultButtonMain(
//               color: AppColors.kPrimary1,
//               width: 120.w,
//               text: back,
//               borderColor: AppColors.kPrimary1,
//               borderRadius: 38.r,
//               height: 48.h,
//               onPressed: () {
//                 Navigator.of(context).pop(true);
//               },
//             ),
//           )
//         ],
//       );
//     },
//   );
// }

//8
// Future<dynamic> displayLogoutDialog(
//   BuildContext context, {
//   required VoidCallback onTap,
//   required ThemeMode themeMode,
//   required ThemeData theme,
// }) async {
//   return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
//         backgroundColor:
//             themeMode == ThemeMode.light ? Colors.white : theme.cardColor,
//         title: Center(
//           child: TextView(
//             text: logOut,
//             fontSize: 16.spMin,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         content: TextView(
//           text: sureYouWntToLgout,
//           fontSize: 14.spMin,
//           maxLines: 2,
//           textAlign: TextAlign.center,
//           fontWeight: FontWeight.w500,
//         ),
//         actions: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: DefaultButtonMain(
//                   color: themeMode == ThemeMode.light
//                       ? AppColors.kWhite200
//                       : AppColors.kTextWhite,
//                   width: 120.w,
//                   textColor: AppColors.kTextBlack,
//                   text: cancel,
//                   borderRadius: 38.r,
//                   borderColor:
//                       themeMode == ThemeMode.dark ? AppColors.kTextBlack : null,
//                   height: 48.h,
//                   onPressed: () {
//                     navigateBack(context);
//                   },
//                 ),
//               ),
//               SizedBox(
//                 width: 5.w,
//               ),
//               Expanded(
//                 child: DefaultButtonMain(
//                   color: AppColors.kPrimary1,
//                   width: 120.w,
//                   text: logOut,
//                   borderColor: AppColors.kPrimary1,
//                   borderRadius: 38.r,
//                   height: 48.h,
//                   onPressed: onTap,
//                 ),
//               ),
//             ],
//           )
//         ],
//       );
//     },
//   );
// }

Future<void> displayRestrictionMessageAlert(
  BuildContext context,
  String title, {
  required String message,
  required bool isDismissible,
  VoidCallback? onTap,
  required ThemeMode themeMode,
  required ThemeData theme,
  // btnOneText,
}) async {
  final width = MediaQuery.sizeOf(context).width;
  showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor:
              themeMode == ThemeMode.light ? AppColors.kWhite : theme.cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            // height: deviceH / 3,
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextView(
                      text: title,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.spMin,
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    TextView(
                      text: message,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      fontSize: 16.spMin,
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    DefaultButtonMain(
                      width: 200.w,
                      text: back,
                      color: themeMode == ThemeMode.light
                          ? AppColors.kWhite
                          : theme.cardColor,
                      borderColor: theme.colorScheme.primary,
                      borderRadius: 38.r,
                      textColor: theme.colorScheme.primary,
                      height: 48.h,
                      onPressed: () {
                        navigateBack(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

Future<void> displayTenantValidationAlert(
  BuildContext context, {
  VoidCallback? useDetails,
  VoidCallback? addNewDetails,
  required ThemeMode themeMode,
  required ThemeData theme,
  // btnOneText,
}) async {
  final width = MediaQuery.sizeOf(context).width;
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor:
              themeMode == ThemeMode.light ? AppColors.kWhite : theme.cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            height: 300.h,
            // height: deviceH / 3,
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //A user Logo
                    // Image.asset(
                    //   AppImages.tenantAccount,
                    //   height: 50.h,
                    //   width: 50.h,
                    //   color: themeMode == ThemeMode.light
                    //       ? AppColors.kPrimary1
                    //       : AppColors.kPrimaryLight,
                    // ),
                    SizedBox(
                      height: 15.h,
                    ),
                    TextView(
                      text: "Do you want to use your previous details",
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      fontSize: 16.spMin,
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    DefaultButtonMain(
                      width: width,
                      text: "Use Details",
                      color: themeMode == ThemeMode.light
                          ? AppColors.kPrimary1
                          : AppColors.kPrimaryDark,
                      borderRadius: 38.r,
                      textColor: theme.scaffoldBackgroundColor,
                      height: 48.h,
                      onPressed: useDetails,
                    ),
                    Gap(10.h),
                    DefaultButtonMain(
                      width: width,
                      text: "Add New Details",
                      color: themeMode == ThemeMode.light
                          ? theme.scaffoldBackgroundColor
                          : AppColors.kTransparent,
                      borderColor: themeMode == ThemeMode.light
                          ? AppColors.kPrimary1
                          : AppColors.kPrimaryDark,
                      borderRadius: 38.r,
                      textColor: themeMode == ThemeMode.light
                          ? AppColors.kPrimary1
                          : AppColors.kPrimaryDark,
                      height: 48.h,
                      onPressed: addNewDetails,
                    ),
                    // buttonConfirmation(
                    //     onPressed: () {
                    //       navigateBack(context);
                    //     },
                    //     text: back,
                    //     gradient: AppColors.white900Gradient,
                    //     textColor: Colors.black)
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

Future<void> displaySwitchConfirmationMessageAlert(
  BuildContext context,
  String title, {
  required String message,
  required bool isDismissible,
  VoidCallback? onTap,
  required ThemeMode themeMode,
  required ThemeData theme,
  // btnOneText,
}) async {
  final width = MediaQuery.sizeOf(context).width;
  showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor:
              themeMode == ThemeMode.light ? Colors.white : theme.cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            // height: 350.h,
            // height: deviceH / 3,
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextView(
                      text: title,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.spMin,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    RichText(
                      text: TextSpan(
                        text: message,
                        style: TextStyle(
                            color: themeMode == ThemeMode.light
                                ? Colors.black
                                : AppColors.kWhite,
                            fontSize: 16.spMin,
                            fontFamily: soraFont,
                            fontWeight: FontWeight.w400),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // TextView(
                    //   text: message,
                    //   fontWeight: FontWeight.w400,
                    //   textAlign: TextAlign.center,
                    //   maxLines: 5,
                    //   fontSize: 16.spMin,
                    // ),
                    SizedBox(
                      height: 26.h,
                    ),

                    DefaultButtonMain(
                      color: AppColors.kPrimary1,
                      width: 200.w,
                      text: continueText,
                      borderColor: AppColors.kPrimary1,
                      borderRadius: 38.r,
                      height: 48.h,
                      onPressed: onTap,
                    ),
                    // buttonConfirmation(
                    //     onPressed: () {
                    //       navigateBack(context);
                    //       navigatePush(context, EditAccountDetailsScreen());
                    //     },
                    //     text: continueText),
                    SizedBox(
                      height: 10.h,
                    ),

                    DefaultButtonMain(
                      width: 200.w,
                      text: back,
                      color: themeMode == ThemeMode.light
                          ? AppColors.kWhite
                          : theme.cardColor,
                      borderColor: theme.colorScheme.primary,
                      borderRadius: 38.r,
                      textColor: theme.colorScheme.primary,
                      height: 48.h,
                      onPressed: () {
                        navigateBack(context);
                      },
                    ),
                    // buttonConfirmation(
                    //     onPressed: () {
                    //       navigateBack(context);
                    //     },
                    //     text: back,
                    //     gradient: AppColors.white900Gradient,
                    //     textColor: Colors.black)
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

Future<void> displayPhoneNumberNullAlert(
  BuildContext context,
  String title, {
  required String message,
  required bool isDismissible,
  VoidCallback? onTap,
  required ThemeMode themeMode,
  required ThemeData theme,
  // btnOneText,
}) async {
  final width = MediaQuery.sizeOf(context).width;
  showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor:
              themeMode == ThemeMode.light ? Colors.white : theme.cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            // height: 350.h,
            // height: deviceH / 3,
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextView(
                      text: title,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.spMin,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    RichText(
                      text: TextSpan(
                        text: message,
                        style: TextStyle(
                            color: themeMode == ThemeMode.light
                                ? Colors.black
                                : AppColors.kWhite,
                            fontSize: 16.spMin,
                            fontFamily: soraFont,
                            fontWeight: FontWeight.w400),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // TextView(
                    //   text: message,
                    //   fontWeight: FontWeight.w400,
                    //   textAlign: TextAlign.center,
                    //   maxLines: 5,
                    //   fontSize: 16.spMin,
                    // ),
                    SizedBox(
                      height: 26.h,
                    ),

                    // buttonConfirmation(
                    //     onPressed: () {
                    //       navigateBack(context);
                    //       navigatePush(context, EditAccountDetailsScreen());
                    //     },
                    //     text: continueText),
                    SizedBox(
                      height: 10.h,
                    ),

                    DefaultButtonMain(
                      color: AppColors.kPrimary1,
                      width: 200.w,
                      text: okayText,
                      borderColor: AppColors.kPrimary1,
                      borderRadius: 38.r,
                      height: 48.h,
                      textColor: Colors.white,
                      onPressed: () {
                        navigateBack(context);
                      },
                    ),
                    // buttonConfirmation(
                    //     onPressed: () {
                    //       navigateBack(context);
                    //     },
                    //     text: back,
                    //     gradient: AppColors.white900Gradient,
                    //     textColor: Colors.black)
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

inProgressBottomModalSheetWidget(BuildContext context,
    {required VoidCallback onTap}) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.kTransparent,
      // isDismissible: false,
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 360.h,
            decoration: BoxDecoration(
              color: AppColors.kPrimaryDark,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  12.r,
                ),
                topRight: Radius.circular(
                  12.r,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15.h,
                horizontal: 15.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    AppImages.inProgressLogo,
                    width: 72.w,
                    height: 72.h,
                  ),
                  Column(
                    children: [
                      TextView(
                        text: "In progress",
                        fontSize: 16.spMin,
                        fontWeight: FontWeight.w600,
                      ),
                      Gap(10.h),
                      TextView(
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        text: "Your order has been received. "
                            "We will notify you when it's ready, usually within 45 seconds",
                        fontSize: 12.spMin,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: DefaultButtonMain(
                      textColor: AppColors.kWhite,
                      color: AppColors.kPrimary1,
                      text: "Back to home",
                      onPressed: onTap,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

addBankBottomModalSheetWidget(BuildContext context, {Widget? widget}) {
  return showModalBottomSheet(
    // shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       topRight: Radius.circular(21.r),
    //       topLeft: Radius.circular(21.r),
    //     )),
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.kTransparent,
    context: context,
    isScrollControlled: false,
    builder: (context) {
      return const AddBankBottomModalSheet();
    },
  );
}

sellCoinBottomModalSheetWidget(BuildContext context, {Widget? widget}) {
  return showModalBottomSheet(
    // shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       topRight: Radius.circular(21.r),
    //       topLeft: Radius.circular(21.r),
    //     )),
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.kTransparent,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return const SellCoinBottomModalSheetContent();
    },
  );
}

class AddBankBottomModalSheet extends ConsumerStatefulWidget {
  const AddBankBottomModalSheet({super.key});

  @override
  ConsumerState<AddBankBottomModalSheet> createState() =>
      _AddBankBottomModalSheetState();
}

class _AddBankBottomModalSheetState
    extends ConsumerState<AddBankBottomModalSheet> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Container(
        // height: 360.h,
        decoration: BoxDecoration(
          color: AppColors.kPrimaryDark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              12.r,
            ),
            topRight: Radius.circular(
              12.r,
            ),
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      navigateBack(context);
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_left,
                      color: AppColors.kNavBlue,
                    ),
                  ),
                  TextView(
                    text: chooseBankText,
                    fontSize: 16.spMin,
                    fontWeight: FontWeight.w600,
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateBack(context);
                    },
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: AppColors.kWhite,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 38.h,
            ),

            bankLists(),
            SizedBox(
              height: 24.h,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: addButton(),
            )

            //
            // DefaultButtonMain(
            //   textColor: AppColors.kWhite,
            //   color: AppColors.kPrimary1,
            //   text: "Back to home",
            //   onPressed: () {
            //     // dashboardProvider.setPageIndexToHome(context);
            //   },
            // )
          ],
        ),
      ),
    );
  }

  Widget bankWidget({
    required String accName,
    required String accNo,
    required String bankName,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: accName,
          fontSize: 12.spMin,
        ),
        SizedBox(
          height: 8.h,
        ),
        TextView(
          text: bankName,
          fontSize: 12.spMin,
          color: AppColors.kCardText,
        ),
        SizedBox(
          height: 8.h,
        ),
        TextView(
          text: accNo,
          fontSize: 12.spMin,
          color: AppColors.kCardText,
        ),
      ],
    );
  }

  bankLists() {
    return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        // Check if it's the last item
        bool isLastItem = index == 1;

        return GestureDetector(
          onTap: () {
            navigateBack(context);
            sellCoinBottomModalSheetWidget(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                ),
                child: bankWidget(
                    accName: 'Daniel Mason Ovie',
                    accNo: '8107143027',
                    bankName: 'Opay'),
              ),
              const TampayDivider(),
            ],
          ),
        );
      },
    );
  }

  addButton() {
    return GestureDetector(
      onTap: () {
        navigatePush(context, const AddBankScreen());
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 35.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                width: 0.5.r, color: AppColors.kCardText.withOpacity(0.3))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: AppColors.kCardText,
              size: 24.r,
            ),
            SizedBox(
              width: 8.w,
            ),
            TextView(
              text: addAnotherBankText,
              fontSize: 12.spMin,
            )
          ],
        ),
      ),
    );
  }
}

class SellCoinBottomModalSheetContent extends ConsumerStatefulWidget {
  const SellCoinBottomModalSheetContent({super.key});

  @override
  ConsumerState<SellCoinBottomModalSheetContent> createState() =>
      _SellCoinBottomModalSheetContentState();
}

class _SellCoinBottomModalSheetContentState
    extends ConsumerState<SellCoinBottomModalSheetContent> {
  @override
  Widget build(BuildContext context) {
    var buySectionProvider = ref.watch(buyViewModel);
    var dashboardProvider = ref.watch(dashboardViewModel);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Container(
        height: 729.h,
        decoration: BoxDecoration(
          color: AppColors.kPrimaryDark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              12.r,
            ),
            topRight: Radius.circular(
              12.r,
            ),
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SizedBox(
            //   height: 20.h,
            // ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          navigateBack(context);
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_left,
                          color: AppColors.kNavBlue,
                        ),
                      ),
                      TextView(
                        text: sellBitcoin,
                        fontSize: 16.spMin,
                        fontWeight: FontWeight.w600,
                      ),
                      GestureDetector(
                        onTap: () {
                          navigateBack(context);
                        },
                        child: const Icon(
                          Icons.cancel_outlined,
                          color: AppColors.kWhite,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: warningPrompt(),
                  ),
                  SizedBox(
                    height: 48.h,
                  ),
                  SizedBox(
                    width: 236.w,
                    child: QrImageView(
                      data: "message",
                      version: QrVersions.auto,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: AppColors.kPrimary1,
                        // borderRadius: 10,
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: AppColors.kPrimary1,
                        // borderRadius: 5,
                        // roundedOutsideCorners: true,
                      ),
                      embeddedImage: const AssetImage('assets/images/4.0x/logo_yakka_transparent.png'),
                      embeddedImageStyle: const QrEmbeddedImageStyle(
                        size: Size.square(40),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  TextView(
                    text: scanToReceive,
                    color: AppColors.kUnselectedBottomItemColor,
                    fontSize: 12.spMin,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  walletAddressCard(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      defaultButton(
                          width: 150.w,
                          text: copy,
                          imagePath: AppImages.copyIcon,
                          color: AppColors.kDarkDividerColor,
                          borderRadius: 8.r,
                          onPressed: () {
                            dashboardProvider.copyToClipboard(
                                'bc1q04tvdada..............wjdgfee7g');
                          }),
                      defaultButton(
                          width: 150.w,
                          text: share,
                          imagePath: AppImages.shareIcon,
                          borderColor: AppColors.kCardText,
                          textColor: AppColors.kCardText)
                    ],
                  ),
                  SizedBox(
                    height: 72.h,
                  ),
                  DefaultButtonMain(
                    color: AppColors.kPrimary1,
                    text: iHaveDeposited,
                    onPressed: () {
                      // navigateBack(context);
                      inProgressBottomModalSheetWidget(context, onTap: () {
                        // navigateBack(context);
                        dashboardProvider.setPageIndexToHome(context);
                      });
                    },
                  ),
                ],
              ),
            ),

            //
            // DefaultButtonMain(
            //   textColor: AppColors.kWhite,
            //   color: AppColors.kPrimary1,
            //   text: "Back to home",
            //   onPressed: () {
            //     // dashboardProvider.setPageIndexToHome(context);
            //   },
            // )
          ],
        ),
      ),
    );
  }

  warningPrompt() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: ensureToSend,
          style: TextStyle(
            // color: theme.colorScheme.primary,
            color: AppColors.kWhite,
            fontSize: 12.spMin,
            fontFamily: soraFont,
            fontWeight: FontWeight.w400,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Bitcoin (BTC)',
              style: TextStyle(
                color: AppColors.kWhite,
                fontSize: 12.spMin,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: toThisAddress,
              style: TextStyle(
                color: AppColors.kWhite,
                fontSize: 12.spMin,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  walletAddressCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              width: 0.5.r, color: AppColors.kCardText.withOpacity(0.3))),
      child: Center(
        child: TextView(
          text: 'bc1q04tvdada..............wjdgfee7g',
          fontSize: 14.spMin,
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
  }) {
    return Container(
      height: height ?? 50.0.h,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0.r),
          border: Border.all(color: borderColor ?? Colors.transparent)),
      child: ButtonTheme(
        child: MaterialButton(
          padding: EdgeInsets.zero,
          height: height ?? 50.0.h,

          onPressed: onPressed,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageView.asset(
                  imagePath,
                  height: 20.h,
                  width: 20.w,
                ),
                SizedBox(
                  width: 8.w,
                ),
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
    );
  }
}

bankAddedSuccessfulBottomModalSheetWidget(
  BuildContext context,
) {
  return showModalBottomSheet(
    // shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       topRight: Radius.circular(21.r),
    //       topLeft: Radius.circular(21.r),
    //     )),
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.kTransparent,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return const BankAddedSuccessfulBottomModalSheetContent();
    },
  );
}

class BankAddedSuccessfulBottomModalSheetContent
    extends ConsumerStatefulWidget {
  const BankAddedSuccessfulBottomModalSheetContent({super.key});

  @override
  ConsumerState<BankAddedSuccessfulBottomModalSheetContent> createState() =>
      _BankAddedSuccessfulBottomModalSheetContentState();
}

class _BankAddedSuccessfulBottomModalSheetContentState
    extends ConsumerState<BankAddedSuccessfulBottomModalSheetContent> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 20,
        sigmaY: 20,
      ),
      child: Container(
        height: 330.h,
        decoration: BoxDecoration(
          color: AppColors.kPrimaryDark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              12.r,
            ),
            topRight: Radius.circular(
              12.r,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 15.w,
          ),
          child: Column(
            children: [
              Image.asset(
                AppImages.successLogo,
                width: 72.w,
                height: 72.h,
              ),
              SizedBox(
                height: 24.h,
              ),
              Column(
                children: [
                  TextView(
                    text: "Bank Added",
                    fontSize: 16.spMin,
                    fontWeight: FontWeight.w600,
                  ),
                  Gap(10.h),
                  TextView(
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    text:
                        "You have successfully added a new bank account details",
                    fontSize: 12.spMin,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(
                height: 62.h,
              ),
              const Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: DefaultButtonMain(
                  textColor: AppColors.kWhite,
                  color: AppColors.kPrimary1,
                  text: "Done",
                  // onPressed: onTap
                  // ,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
