import 'package:flutter/material.dart';
import 'package:tampay/src/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/providers.dart';

class TampayDivider extends ConsumerWidget {
  const TampayDivider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeViewModel);
    return SizedBox(
      width: double.infinity.w,
      child: Divider(
        color: AppColors.kDarkDividerColor,
        thickness: 0.5.h,
      ),
    );
  }
}
