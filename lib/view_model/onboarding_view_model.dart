
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:rebirth/rebirth.dart';
import 'package:tampay/model/local/dummy_data.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/src/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';


final onboardingViewModel =
    ChangeNotifierProvider((ref) => OnboardingViewModel());

class OnboardingViewModel extends ChangeNotifier {
  late SharedPreferences sharedPreferences;

  checkUser(context) {
    initData().then((onValue) async {


      sharedPreferences = await SharedPreferences.getInstance();
      DummyData.isDarkTheme = sharedPreferences.getBool("isDarkTheme") ?? false;
      DummyData.firstTimeOnApp = sharedPreferences.getBool("firstTimeOnApp");

      if (DummyData.firstTimeOnApp == true ||
          DummyData.firstTimeOnApp == null ||
          DummyData.accessToken == null) {
         navigateReplace(context, const OnboardingScreen());

      } else {
        logger.i("Check User");
        //  DummyData.localUserID = sharedPreferences.getString("UserID");`
        DummyData.emailAddress = sharedPreferences.getString("Email");
        DummyData.password = sharedPreferences.getString("Password");
        DummyData.accessToken = sharedPreferences.getString("accessToken");

        logger.i(DummyData.emailAddress);
        logger.i(DummyData.accessToken);

        bool hasExpired = Jwt.isExpired(DummyData.accessToken.toString());
        logger.w(hasExpired);

        if (!hasExpired) {
          await ProfileViewModel().loadData(context).then((value) async {
            if (value != null) {
              DummyData.firstName = value.firstName.toString();
              DummyData.lastName = value.lastName.toString();
             // await navigateReplace(context, const DashBoardScreen());
            } else {
              SharedPreferences prefs =
              await SharedPreferences.getInstance();
              await prefs.remove('Email');
              await prefs.remove('Password');
              await prefs.remove('accessToken');
              DummyData.firstName = '';
              DummyData.lastName = '';
              await Future.delayed(const Duration(seconds: 2));
              WidgetRebirth.createRebirth(context: context);
              // navigateReplace(context, const DashBoardScreen(setIndex: 1,));
            }
          });
        } else {
          if (DummyData.emailAddress != null && DummyData.password != null) {
            logger.i(DummyData.emailAddress);
            logger.i(DummyData.password);
            AuthViewModel().userAutoLogin(context,
                email: DummyData.emailAddress.toString(),
                password: DummyData.password.toString());
          } else {
            // navigateReplace(context, const OnboardingScreen());
            // logger.e("error");
          }
        }

      }
    });
  }

  Future<void> initData() async {
    await Future<void>.delayed(const Duration(seconds: 3));
  }
}