import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';


class PreferencesScreen extends ConsumerStatefulWidget {
  const PreferencesScreen({super.key});

  @override
  ConsumerState<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends ConsumerState<PreferencesScreen> {
  @override
  Widget build(BuildContext context) {
   var settingsProvider = ref.watch(settingsViewModel);

   var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBars.mainAppBar(
        context,
        bottomText: 'Preferences',
      ),
      body: SafeArea(
        child: XResponsiveWrap.mobile(
          onRefresh: () {
            return settingsProvider.loadData();
          },
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          // loading: provider.isGettingPersonalListings,
          // loadFailed:  recycleProvider.recycleHistoryResponse!.data == [],
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Gap(30),
                  ListItems(
                    icon: AppImages.friendsIcon,
                    onPressed: () {},
                    subText: "Choose your default currency",
                    title: "Currency",
                  ),
                  ListItems(
                    icon: AppImages.friendsIcon,
                    onPressed: () {},
                    isToggleChange: true,

                    subText: "Send in app notification for an activity",
                    title: "Push Notification",
                    value:  settingsProvider.sendPushNotification,
                    onChanged: settingsProvider.togglePushNotification,
                  ),
                  ListItems(
                    icon: AppImages.friendsIcon,
                    onPressed: () {},
                    isToggleChange: true,
                    subText: "Send notification to email",
                    title: "Email Notification",
                    value:  settingsProvider.sendEmailNotification,
                    onChanged: (val) => settingsProvider.toggleEmailNotification(val),
                  ),
                  ListItems(
                    icon: AppImages.friendsIcon,
                    onPressed: () {},
                    isToggleChange: true,
                    subText: "Send marketing update to email",
                    title: "Promotion",
                    value:  settingsProvider.sendPromotionsEmail,
                    onChanged: settingsProvider.togglePromotionsEmail,
                  ),
                  ListItems(
                    icon: AppImages.bankIcon,
                    onPressed: () {},
                    subText:  "Select the feel of your app",
                    title: "Dark Theme",
                    isToggleChange: false,
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
