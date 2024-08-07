import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/utils.dart';

class InviteFriendCard extends ConsumerStatefulWidget {
  const InviteFriendCard({
    super.key,
    this.title,
    this.subText,
  });
  final String? title;
  final String? subText;
  @override
  ConsumerState<InviteFriendCard> createState() => _InviteFriendCardState();
}

class _InviteFriendCardState extends ConsumerState<InviteFriendCard> {
  @override
  Widget build(BuildContext context) {
    var  themeMode = ref.watch(themeViewModel).themeMode;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
      decoration:
          BoxDecoration(color:
          themeMode == ThemeMode.light ? AppColors.kLightSilver : AppColors.kOnyxBlack,
              borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        children: [
          ImageView.asset(
            AppImages.inviteRefIcon,
            width: 30.w,
            color:  themeMode == ThemeMode.light ? AppColors.kPrimary1 : AppColors.kWhite,
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 3.w,
                ),
                TextView(
                  text: widget.subText ?? inviteYourFriendsInfo,
                  fontWeight: FontWeight.w400,
                  fontSize: 10.spMin,
                  maxLines: 3,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
class ReferralsDetailBox extends StatelessWidget {
  const ReferralsDetailBox({
    super.key,
    required this.detailTitle,
    required this.detailValue,
    required this.color,
    required this.textColor,
  });
  final String detailTitle;
  final String detailValue;
  final Color color;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 8.w),
      width: 165.w,
      decoration: BoxDecoration(color: color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(10.h),
          TextView(
              text: detailTitle, color: textColor
          ),
          Gap(10.h),
          TextView(
              text: detailValue,
              fontSize: 24.spMin, color: textColor
            //  fontWeight: FontWeight.w600,
          ),
          Gap(70.h),
        ],
      ),
    );
  }
}


class ReferralUser extends ConsumerWidget {

  final String name;
  final String date;
  final String amount;

  const ReferralUser({super.key, required this.name, required this.date, required this.amount});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {
    var themeMode = ref.watch(themeViewModel).themeMode;
    return    Padding(
      padding:  EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color:  themeMode == ThemeMode.light ? AppColors.kLightSilver : AppColors.kOnyxBlack,
        ),
        child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ProfileImage(imageType: ProfileImageType.user),

            SizedBox( width: 280.w,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextView(
                        text: name,
                      ),
                      const TextView(
                        text: "You Earned", color: AppColors.kGrey500,
                      ),
                    ],
                  ),
                  const Gap(6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextView(
                        text: "Joined ${UtilFunctions.formatDate(date)}", color: AppColors.kGrey500,
                      ),
                      TextView(
                        text: "₦ ${UtilFunctions.formatAmount(double.parse(amount))}",
                      ),

                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class ReferralLeaderBoardUser extends ConsumerWidget {

  final String name;
  final String userName;
  final String rank;

  const ReferralLeaderBoardUser({super.key, required this.name, required this.userName, required this.rank});


  @override
  Widget build(BuildContext context, WidgetRef ref ) {
    var themeMode = ref.watch(themeViewModel).themeMode;
    return    Padding(
      padding:  EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color:  themeMode == ThemeMode.light ? AppColors.kLightSilver : AppColors.kOnyxBlack,
        ),
        child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ProfileImage(imageType: ProfileImageType.user),

            SizedBox( width: 280.w,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextView(
                        text: name,
                      ),
                      const TextView(
                        text: "Rank", color: AppColors.kGrey500,
                      ),
                    ],
                  ),
                  const Gap(6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextView(
                        text:  userName, color: AppColors.kGrey500,
                      ),

                      TextView(
                        text: rank,
                      ),

                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

