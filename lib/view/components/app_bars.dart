import 'package:flutter/material.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/utils.dart';

class AppBars {
  static PreferredSizeWidget mainAppBar(
    BuildContext context, {
    String? text,
    Widget? trailing,
    String? bottomText,
    double? textSize,
    void Function()? callback,
    bool isVisible = true,
    bool bottomVisible = true,
  
    Color? titleColor,
    bool? iWantToEditAProperty,
  }) {
    ThemeData theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 90.w,
      automaticallyImplyLeading: false,
      leading: Visibility(
        visible: isVisible,
        child: InkWell(
            onTap: () {
              navigateBack(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap(15),
                GestureDetector(
                  onTap: () {
                    if (callback != null) {
                      callback();
                    }
                    navigateBack(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 18.r,
                    color: theme.colorScheme.primary,
                  ),
                ),
                TextView(
                  text: back,
                  fontSize: 14.spMin,
                  fontFamily: soraFont,
                  fontWeight: FontWeight.w600,
                )
              ],
            )),
      ),
      title: text != null
          ? TextView(
              text: text,
              fontSize: textSize == null ? 20.spMin : textSize.spMin,
              fontFamily: soraFont,
              fontWeight: FontWeight.w600,
            )
          : const SizedBox.shrink(),
      centerTitle: true,
      actions: [trailing ?? const SizedBox.shrink()],
      bottom: bottomVisible
          ? PreferredSize(
              preferredSize: Size(0, 20.h),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Gap(15),
                      bottomText != null
                          ? TextView(
                              text: bottomText,
                              fontSize: textSize == null ? 20.spMin : textSize.spMin,
                              fontFamily: soraFont,
                              fontWeight: FontWeight.w600,
                            )
                          : const SizedBox.shrink(),
                    ],
                  )))
          : null,
    );
  }
}
