import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rebirth/rebirth.dart';
import 'package:tampay/src/config.dart';
import 'package:tampay/src/screens.dart';
import 'package:tampay/view/screens/auth/signin_forgot_password/welcome_back_screen.dart';
import 'package:tampay/view/screens/sticky.dart';
import 'package:tampay/view_model/theme_view_model.dart';
import 'package:smile_id/smile_id.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SmileID.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (value) => runApp(
          const WidgetRebirth(materialApp: ProviderScope(child: MyApp()))));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void didChangeDependencies() {
    ref.watch(themeViewModel).init();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    initPlatformState();
    super.initState();

  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    SmileID.initialize();
  }
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(themeViewModel);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      // designSize:  Size(WidgetsBinding.instance.window.physicalSize.width/3, WidgetsBinding.instance.window.physicalSize.height/3),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          themeMode: themeProvider.themeMode,
          darkTheme: AppTheme.darkTheme,
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: child,
        );
      },


      child: const WelcomeBackScreen(),
    );
  }
}
