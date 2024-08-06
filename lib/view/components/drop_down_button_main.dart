// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';

class DropDownButtonMain extends ConsumerWidget {
  DropDownButtonMain({
    super.key,
    required this.title,
    required this.hintText,
    required this.onTap,
    required this.items,
    this.colour,
    this.titleSize,
    this.titleWeight,
    this.label,
  });
  String hintText;
  String? title;
  double? titleSize;
  FontWeight? titleWeight;
  String? label;
  Color? colour;
  List<DropdownMenuItem<String>>? items;
  Function(String? value) onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Theme.of(context);
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: label != null,
            child: Column(
              children: [
                TextView(text: label.toString()),
                Gap(5.h),
              ],
            )),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.spMin, vertical: 4.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: themeMode == ThemeMode.light ? AppColors.kLightSilver : AppColors.kOnyxBlack,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  hintText,
                  style: TextStyle(
                      color:
                          themeMode == ThemeMode.light ? AppColors.kTextBlack : AppColors.kWhite),
                ),
                value: title,
                icon: Image.asset(
                  AppImages.dropDownIcon,
                  color: themeMode == ThemeMode.light ? AppColors.kTextBlack : AppColors.kWhite,
                  width: 20.w,
                  height: 20.h,
                ),
                style: TextStyle(
                    color: themeMode == ThemeMode.light ? AppColors.kTextBlack : AppColors.kWhite),
                onChanged: onTap,
                items: items),
          ),
        ),
      ],
    );
  }
}
