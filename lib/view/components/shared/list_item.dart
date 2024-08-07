import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';

class ListItems extends ConsumerWidget {
  const ListItems({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.subText,
    required this.title,
    this.isToggleChange = false,
    this.isThemeChange = false,
    this.isLogout = false,
    this.value = false,
    this.onChanged ,
  });

  final String icon;
  final String title;
  final String subText;
  final bool isToggleChange;
  final bool isThemeChange;
  final bool isLogout;
  final bool value;
  final VoidCallback onPressed;
  final  ValueChanged<bool>? onChanged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeMode themeMode = ref.watch(themeViewModel).themeMode;
    var themeProvider = ref.watch(themeViewModel);
    var settingsProvider = ref.watch(settingsViewModel);
    return GestureDetector(
      onTap: !isLogout && ! isToggleChange && !isThemeChange ?  onPressed : null,
      child: Container(
        padding:  EdgeInsets.symmetric(vertical: 15.h, horizontal: 0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 45.w,
                  height: 45.h,
                  decoration:  BoxDecoration(
                      shape: BoxShape.circle, color: isLogout ? AppColors.kError300 :
                  themeMode == ThemeMode.light?  AppColors.kPrimary1 : AppColors.kGrey300
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImageView.asset(
                        icon,
                        width: 20.w,
                        height: 20.h,
                        color:  isLogout ? AppColors.kWhite :  themeMode == ThemeMode.light ? AppColors.kWhite : AppColors.kGrey900,
                    ),
                  ),
                ),
                Gap(10.w),
                SizedBox( height: 70.h, width: 230.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        text: title,
                        fontSize: 14.spMin,
                      ),
                      isLogout ? const SizedBox.shrink() : const Gap(6),
                      isLogout ? const SizedBox.shrink() : TextView(
                        text: subText, maxLines: 2,
                        color: themeMode == ThemeMode.light ? AppColors.kGrey500 : AppColors.kGrey400,
                      ),
                    ],
                  ),
                )
              ],
            ),
            !isToggleChange ? Icon(
              Icons.arrow_forward_ios,
              size: 18.r,
              // color: theme.colorScheme.primary,
            ) :  isThemeChange ?    ListenableBuilder(
                listenable: themeProvider,
                builder: (BuildContext context, Widget? child) {
                  final themeMode = themeProvider.themeMode;

                  return CupertinoSwitch(
                    value: themeMode == ThemeMode.dark,
                    onChanged: (value) async {
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      if (value) {
                        themeProvider.setThemeMode(ThemeMode.dark);
                        prefs.setBool('isDarkTheme', true);
                        prefs.setString('AppTheme', "Dark Mode");
                        return;
                      }
                      themeProvider.setThemeMode(ThemeMode.light);
                      prefs.setBool('isDarkTheme', false);
                      prefs.setString('AppTheme', "Light Mode");
                    },
                    activeColor: themeMode == ThemeMode.light
                        ? AppColors.kPrimary1
                        : AppColors.kPrimary1,
                  );
                }) :   ListenableBuilder(
                listenable: settingsProvider,
                builder: (BuildContext context, Widget? child) {
                  return CupertinoSwitch(
                    value: value,
                    onChanged: (value) async => onChanged!(value),
                    activeColor: themeMode == ThemeMode.light ? AppColors.kPrimary1
                        : AppColors.kPrimary1,
                  );
                })
          ],
        ),
      ),
    );
  }
}

