import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';

class TPayDefaultProgressStatusPopUp extends ConsumerWidget {
  const TPayDefaultProgressStatusPopUp({
    super.key,
    this.action,
    this.progressStatusLogo,
    this.progressStatusTextBody,
    this.height = 500.0,
    this.progressStatusTextTitle,
  });

  final String? progressStatusLogo;
  final String? progressStatusTextTitle;
  final String? progressStatusTextBody;
  final Widget? action;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    return Container(
      height: height.h,
      decoration: BoxDecoration(
        color: themeMode == ThemeMode.dark ? AppColors.kCharcoalBlack : AppColors.kTextWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            32.r,
          ),
          topRight: Radius.circular(
            32.r,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
          horizontal: 30.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            progressStatusLogo == null
                ? const SizedBox.shrink()
                : Image.asset(
                    progressStatusLogo!,
              width: 42.w,
              height: 42.h,
            ),
            Column(
              children: [
                TextView(
                  text: progressStatusTextTitle ?? "",
                  fontSize: 16.spMin,
                  fontWeight: FontWeight.w600,
                ),
                Gap(10.h),
                TextView(
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  text: progressStatusTextBody ?? "",
                  fontSize: 12.spMin,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            Align(alignment: AlignmentDirectional.center, child: action)
          ],
        ),
      ),
    );
  }
}

class TPayDefaultPopUp extends ConsumerWidget {
  const TPayDefaultPopUp({
    super.key,
    this.action,
  });

  final Widget? action;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    return Container(
      decoration: BoxDecoration(
        color: themeMode == ThemeMode.dark ? AppColors.kCharcoalBlack : AppColors.kTextWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            24.r,
          ),
          topRight: Radius.circular(
            24.r,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: 15.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
              text: "Confirm Details",
              textStyle: theme.textTheme.titleLarge!.copyWith(fontSize: 16.spMin),
            ),
            Column(
              children: [
                const CustomTextField(
                  fieldLabel: "Full Name",
                  readOnly: true,
                  hint: dummyName,
                ),
                Gap(10.h),
                const CustomTextField(
                  fieldLabel: "Date of Birth",
                  readOnly: true,
                  hint: "",
                ),
                Gap(10.h),
                CustomTextField(
                  fieldLabel: "Phone Number",
                  readOnly: true,
                  hint: "",
                  showSuffixIcon: true,
                  trailing: Image.asset(
                    AppImages.editTextLogo,
                    width: 14.w,
                    height: 14.h,
                  ),
                ),
              ],
            ),
            action ?? const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
