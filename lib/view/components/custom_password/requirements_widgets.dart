import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';

class PassCheckRequirements extends ConsumerWidget {
  const PassCheckRequirements({
    super.key,
    this.passCheck,
    this.requirementText,
    this.activeIcon,
    this.inActiveIcon,
    this.inActiveColor,
    this.activeColor,
  });

  /// a `bool` value as check [required] field in case you want to `modify` the package
  final bool? passCheck;

  /// requirement text [required] field in case you want to `modify` the package
  final String? requirementText;

  /// IconData when requirement is completed
  final IconData? activeIcon;

  /// IconData when requirement is not completed/inActive
  final IconData? inActiveIcon;

  /// inActive color
  final Color? inActiveColor;

  /// Active color
  final Color? activeColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
   
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        children: [
          /// requirement IconData based on check!
          Icon(
              Icons.check_circle_outline_rounded,
            color: passCheck!
                ? AppColors.kGreenishTeal
                : themeMode == ThemeMode.dark
                    ? AppColors.kManatee
                    : AppColors.kGrey800,
            ),
          const SizedBox(width: 8),

          /// requirement text
          Text(
            requirementText!,
            style: TextStyle(
              color: passCheck!
                  ? AppColors.kGreenishTeal
                  : themeMode == ThemeMode.dark
                      ? AppColors.kManatee
                      : AppColors.kGrey800,
              fontFamily: soraFont,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
