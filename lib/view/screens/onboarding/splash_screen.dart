import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tampay/src/config.dart';
import 'package:tampay/src/providers.dart';
import 'package:tampay/view/components/moving_circles.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
   ref.read(onboardingViewModel).checkUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(themeViewModel);
    return Scaffold( backgroundColor: AppColors.kBlack8,
      body: Stack(
        children: [
          const MovingCircles(),
          Center(
            child: Image.asset(
              AppImages.tpayLogo,
              width: 91.w,
              height: 91.h,
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
