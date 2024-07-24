import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/config/app_strings.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

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
            arrowBackColor: theme.colorScheme.primary, text: notification),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            child: Column(
              children: [
                TabBar(
                  dividerColor: AppColors.kTransparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: AppColors.kGrey500,
                  indicatorColor: AppColors.kPrimary1,
                  physics: const BouncingScrollPhysics(),
                  tabs: [
                    Tab(
                      child: TextView(
                        text: "System",
                        fontSize: 14.spMin,
                      ),
                    ),
                    Tab(
                      child: TextView(
                        text: "Transactions",
                        fontSize: 14.spMin,
                      ),
                    ),
                  ],
                ),
                Gap(15.h),
                Expanded(
                  child: TabBarView(
                    children: [
                      ListView(
                        children: List.generate(
                          20,
                          (index) => SystemNotificationTabView(),
                        ),
                      ),
                      TransactionsNotificationTabView(),
                    ],
                  ),
                )
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

class TransactionsNotificationTabView extends StatelessWidget {
  const TransactionsNotificationTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: "Today",
            fontSize: 10.spMin,
            color: AppColors.kGrey500,
          ),
          Gap(15.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    AppImages.receiveMoneyLogo,
                    width: 24.w,
                    height: 24.h,
                  ),
                  Positioned(
                    right: 15,
                    child: Container(
                      width: 6.w,
                      height: 6.h,
                      decoration:
                          const BoxDecoration(shape: BoxShape.circle, color: AppColors.kError300),
                    ),
                  )
                ],
              ),
              Gap(10.w),
              Expanded(
                child: TextView(
                  maxLines: 20,
                  text:
                      "payout of 0.001158 Bitcoin (BTC) was made and has been sent to 8107-daniel successfully.",
                  fontSize: 10.spMin,
                  color: AppColors.kGrey300,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SystemNotificationTabView extends StatelessWidget {
  const SystemNotificationTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: "Today",
            fontSize: 10.spMin,
            color: AppColors.kGrey500,
          ),
          Gap(15.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    AppImages.tPayLogo,
                    width: 22.w,
                    height: 22.h,
                    color: AppColors.kPrimary1,
                  ),
                  Positioned(
                    left: 13,
                    child: Container(
                      width: 6.w,
                      height: 6.h,
                      decoration:
                          const BoxDecoration(shape: BoxShape.circle, color: AppColors.kError300),
                    ),
                  )
                ],
              ),
              Gap(10.w),
              Expanded(
                child: TextView(
                  maxLines: 20,
                  text: "New Login Alert: "
                      "A sign-in from Lagos Nigeria, 19:32:323:00 on an android device was detected. Make sure it was you. If not you, "
                      "contact support as soon as possible",
                  fontSize: 10.spMin,
                  color: AppColors.kGrey300,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
