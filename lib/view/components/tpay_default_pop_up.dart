import 'package:flutter/material.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';

class TPayDefaultProgressStatusPopUp extends StatelessWidget {
  const TPayDefaultProgressStatusPopUp({
    super.key,
    this.action,
    this.progressStatusLogo,
    this.progressStatusTextBody,
    this.progressStatusTextTitle,
  });

  final String? progressStatusLogo;
  final String? progressStatusTextTitle;
  final String? progressStatusTextBody;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360.h,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            12.r,
          ),
          topRight: Radius.circular(
            12.r,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: 15.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              progressStatusLogo ?? "",
              width: 72.w,
              height: 72.h,
            ),
            Column(
              children: [
                TextView(
                  text: progressStatusTextTitle ?? "",
                  fontSize: 16.spMin,
                  fontWeight: FontWeight.w600,
                ),
                Gap(10.h),
                TextView(
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  text: progressStatusTextBody ?? "",
                  fontSize: 12.spMin,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            Align(alignment: AlignmentDirectional.bottomEnd, child: action)
          ],
        ),
      ),
    );
  }
}
