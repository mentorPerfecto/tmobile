import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampay/src/components.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/models.dart';
import 'package:tampay/src/providers.dart';


class PreferencesScreen extends ConsumerStatefulWidget {
  const PreferencesScreen({super.key});

  @override
  ConsumerState<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends ConsumerState<PreferencesScreen> {
  late SharedPreferences prefs;
  @override
  void initState()  {

    Future.microtask(() async {
      prefs = await SharedPreferences.getInstance();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   var settingsProvider = ref.watch(settingsViewModel);
   var themeProvider = ref.watch(themeViewModel);

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
                  const Gap(30),
                  // ListItems(
                  //   icon: AppImages.friendsIcon,
                  //   onPressed: () {},
                  //   subText: "Choose your default currency",
                  //   title: "Currency",
                  // ),
                  ListItems(
                    icon: AppImages.notificationCircle,
                    onPressed: () {},
                    isToggleChange: true,

                    subText: "Send in app notification for an activity",
                    title: "Push Notification",
                    value:  settingsProvider.sendPushNotification,
                    onChanged: settingsProvider.togglePushNotification,
                  ),
                  ListItems(
                    icon: AppImages.notificationCircle,
                    onPressed: () {},
                    isToggleChange: true,
                    subText: "Send notification to email",
                    title: "Email Notification",
                    value:  settingsProvider.sendEmailNotification,
                    onChanged: (val) => settingsProvider.toggleEmailNotification(val),
                  ),
                  ListItems(
                    icon: AppImages.notificationSquareIcon,
                    onPressed: () {},
                    isToggleChange: true,
                    subText: "Send marketing update to email",
                    title: "Promotion",
                    value:  settingsProvider.sendPromotionsEmail,
                    onChanged: settingsProvider.togglePromotionsEmail,
                  ),
                  ListItems(
                    icon: AppImages.moonIcon,
                    onPressed: () async {    await showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.black38,
                    context: context,
                    builder: (context) {

                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: TPayDefaultPopUp(
                          action: SizedBox( height: 250.h,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                
                                TextView(text: "Mode", fontSize: 24.spMin,),
                                ListenableBuilder(
                                    listenable: themeProvider,
                                    builder: (BuildContext context, Widget? child) {
                                      DummyData.appTheme = prefs.getString("AppTheme");
                                      return  ListView.builder( shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          itemCount: themeProvider.modes.length ,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            return  GestureDetector(
                                              onTap: () async {
                                                String setTheme = themeProvider.selectAppTheme(themeProvider.modes[index].toString());

                                               if(setTheme == 'System Mode'){
                                                 themeProvider. setThemeMode( ThemeMode.system == ThemeMode.dark ?  ThemeMode.dark :  ThemeMode.light);
                                                 prefs.setBool('isDarkTheme', ThemeMode.system == ThemeMode.dark);
                                                 prefs.setString('AppTheme', "System Mode");
                                               } else{
                                                 if (setTheme == 'Dark Mode') {
                                                   themeProvider.setThemeMode(ThemeMode.dark);
                                                   prefs.setBool('isDarkTheme', true);
                                                   prefs.setString('AppTheme', "Dark Mode");
                                                   return;
                                                 } else {
                                                   themeProvider.setThemeMode(ThemeMode.light);
                                                   prefs.setBool('isDarkTheme', false);
                                                   prefs.setString('AppTheme', "Light Mode");
                                                 }
                                               }

                                              },
                                              child: ListTile(
                                                  title: TextView(text: themeProvider.modes[index].toString(),),
                                                  trailing:  DummyData.appTheme ==  themeProvider.modes[index] ?
                                                  const Icon(Icons.check_circle_outline, color: AppColors.kPrimary1,) : const SizedBox.shrink()
                                              ),
                                            );
                                          });
                                    })

                              ],
                            ),
                          ),
                        ),
                      );
                    });},
                    subText:  "Select the feel of your app",
                    title: "App Theme",
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
