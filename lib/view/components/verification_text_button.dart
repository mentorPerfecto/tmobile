import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';

class VerificationTextButton extends ConsumerWidget {
  const VerificationTextButton({
    super.key,
    required this.isProfileScreen,
  });
  final bool isProfileScreen;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration:
          BoxDecoration(color: const Color(0xFFCCFCD1), borderRadius: BorderRadius.circular(4.r)),
      child: Center(
        child: TextView(
          text: isProfileScreen ? level2 : verified,
          fontSize: 10.spMin,
          color: const Color(0xFF009A47),
        ),
      ),
    );
  }
}
