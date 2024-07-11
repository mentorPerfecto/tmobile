import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/config/app_colors.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';

class InviteFriendCard extends ConsumerStatefulWidget {
  const InviteFriendCard({super.key});

  @override
  ConsumerState<InviteFriendCard> createState() => _InviteFriendCardState();
}

class _InviteFriendCardState extends ConsumerState<InviteFriendCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
        decoration: BoxDecoration(
            color: AppColors.kPurple,
            borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          children: [
            ImageView.asset(
              AppImages.inviteYourFriendsLogo,
              width: 28.5.w,
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextView(
                    text: inviteYourFriendsText,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 3.w,
                  ),
                  TextView(
                    text: inviteYourFriendsInfo,
                    fontWeight: FontWeight.w400,
                    fontSize: 10.spMin,
                    maxLines: 3,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
