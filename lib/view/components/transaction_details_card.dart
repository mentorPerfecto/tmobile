import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';

class TransactionDetails extends ConsumerWidget {
  TransactionDetails({
    super.key,
    this.label,
    required this.details,
  });
  final String? label;
  final List<Widget> details;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: label ?? "",
                    fontSize: 14.spMin,
                  ),
                  Gap(15.h),
                ],
              ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 18.h,
            horizontal: 20.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: themeMode == ThemeMode.light ? AppColors.kLightSilver : AppColors.kOnyxBlack,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: details,
          ),
        )
      ],
    );
  }
}

class Details extends ConsumerWidget {
  const Details({
    super.key,
    required this.title,
    required this.trailing,
  });
  final String title;
  final Widget trailing;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextView(
          text: title,
          color: themeMode == ThemeMode.light ? AppColors.kGrey600 : AppColors.kGrey400,
        ),
        trailing
      ],
    );
  }
}
