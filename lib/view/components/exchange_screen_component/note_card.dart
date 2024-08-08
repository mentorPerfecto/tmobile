import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';

class SomethingToNote extends ConsumerWidget {
  const SomethingToNote({super.key, required this.thingsToNote});
  final Widget thingsToNote;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 18.h,
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: themeMode == ThemeMode.light ? AppColors.kSunFlower : AppColors.kWarning500,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextView(
            text: "Note",
            color: AppColors.kWhite,
            fontSize: 14.spMin,
          ),
          Gap(15.h),
          thingsToNote,
        ],
      ),
    );
  }
}
