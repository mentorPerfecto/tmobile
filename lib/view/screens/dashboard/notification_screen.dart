import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBars.mainAppBar(context,
          bottomText: notification,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            child: const Column(
              children: [

                SystemNotificationTabView()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationScreenEmptyState extends StatelessWidget {
  const NotificationScreenEmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.placeholderNotificationLogo,
            width: 117.w,
            height: 86.h,
          ),
          Gap(30.h),
          TextView(
            text: "All your notifications will appear here",
            fontSize: 14.spMin,
            color: AppColors.kSlateGrey,
          ),
          Gap(15.h),
          TextView(
            onTap: () {},
            text: "Refresh",
            fontSize: 14.spMin,
            fontWeight: FontWeight.w600,
            color: AppColors.kPrimary1,
          )
        ],
      ),
    );
  }
}


class SystemNotificationTabView extends ConsumerWidget {
  const SystemNotificationTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeProvider = ref.watch(themeViewModel).themeMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: "TODAY",
          fontSize: 12.spMin,
          color: AppColors.kGrey500,  letterSpacing: 5,
        ),
        Gap(15.h),
        Container(
          decoration: BoxDecoration(
              color:  themeProvider ==ThemeMode.dark?
              AppColors.kOnyxBlack : AppColors.kLightSilver,
              borderRadius: BorderRadius.all(Radius.circular(24.r))
          ),
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ListTile(
           title:  TextView(text: 'New Login Alert:', fontWeight: FontWeight.w700, fontSize: 12.spMin,),
           subtitle:  Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Gap(10),
               TextView(text: 'A sign-in from Lagos Nigeria, 19:32:323:00 on an '
                   'android device was detected. Make sure it was you. If not you, '
                   'contact support as soon as possible',
               maxLines: 5, fontSize: 12.spMin,),
               const Gap(10),
               TextView(text: '12:45PM', fontSize: 12.spMin,  color: AppColors.kGrey500,),
             ],
           ),
           trailing: Icon(
             Icons.arrow_forward_ios,
             size: 18.r,
             // color: theme.colorScheme.primary,
           ),
                       ),
        ),
      ],
    );
  }
}
