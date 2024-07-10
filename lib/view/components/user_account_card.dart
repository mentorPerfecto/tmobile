import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';

class UserAccountCard extends ConsumerWidget {
  const UserAccountCard({
    super.key,
    this.screenWidth,
    // this.sixtyOfScreenSize,
    required this.leadingLogo,
    this.onTap,
    required this.subTitleText,
    required this.title,
    this.trailing,
    required this.titleColor,
    required this.subTitleColor,
    required this.subTitleDouble,
    required this.subTitleFontWeight,
    required this.titleDouble,
    required this.titleFontWeight,
    required this.leadingLogoContainerColor,
    this.entireWidgetOnTap,
  });

  final double? screenWidth;
  // final double? sixtyOfScreenSize;
  final Widget leadingLogo;
  final Widget? trailing;
  final String title;
  final String subTitleText;
  final VoidCallback? onTap;
  final Color titleColor;
  final Color subTitleColor;
  final double titleDouble;
  final FontWeight titleFontWeight;
  final double subTitleDouble;
  final FontWeight subTitleFontWeight;
  final Color leadingLogoContainerColor;
  final VoidCallback? entireWidgetOnTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeMode = ref.watch(themeViewModel).themeMode;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: entireWidgetOnTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          height: 55.h,
          width: screenWidth!.w,
          color: AppColors.kTransparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             // Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    // width: 220.w,
                    // height: 57.h,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 2.h,
                          ),
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: leadingLogoContainerColor,
                          ),
                          child: leadingLogo,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SizedBox(
                          width: 140.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                text: title,
                                fontSize: titleDouble,
                                fontWeight: titleFontWeight,
                                fontFamily: soraFont,
                                color: titleColor,
                                maxLines: 2,
                              ),
                              // Gap(5.h),
                              // TextView(
                              //   text: subTitleText,
                              //   fontSize: subTitleDouble,
                              //   fontWeight: subTitleFontWeight,
                              //   fontFamily: soraFont,
                              //   color: subTitleColor,
                              // )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onTap,
                      child: trailing ?? const SizedBox.shrink(),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 1.h,
                width: screenWidth,
                child: Divider(
                  color: themeMode == ThemeMode.light
                      ? AppColors.kDisabledButton
                      : AppColors.kLightAsh,
                  thickness: 1.h,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
