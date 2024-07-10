import 'package:flutter/material.dart';
import 'package:tampay/src/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/providers.dart';

class tampayDivider extends ConsumerWidget {
  const tampayDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeViewModel);
    var theme = Theme.of(context);
    return SizedBox(
      height: 1.5.h,
      width: double.infinity.w,
      child: Divider(
        color: theme.dividerColor,
        thickness: 1.5.h,
      ),
    );
  }
}
