import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:musicplayer/Constants/Language/language_constant.dart';
import 'package:musicplayer/Constants/audio_constant.dart';
import 'package:musicplayer/Ads/appAds.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:musicplayer/Language/AppLanguage.dart';
import 'package:musicplayer/UI/DownloadScreen/downloadscreen.dart';
import 'package:musicplayer/firebase_options.dart';
import 'package:musicplayer/theme/app_theme.dart';
import 'package:musicplayer/theme/theme.dart';
import 'package:musicplayer/theme/themeNotifier.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controller/user_controller.dart';
import 'UI/BottomNavigatorBar/bottomnavigatorbar.dart';
import 'UI/OnBoardingScreen/onboardingscreen.dart';
import 'UI/SplashScreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  ///one signal notification

  const String oneSignalAppId = "27222528-9375-40f3-88e6-857a62b8cc31";

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize(oneSignalAppId);

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);


  userLanguage();
  SharedPreferences.getInstance().then((prefs) {
    themeMode = prefs.getInt('themeMode') ?? 0;
    runApp(
      ChangeNotifierProvider<ThemeModeNotifier>(
        create: (_) {
          ThemeModeNotifier(ThemeMode.values[themeMode]).setThemeMode(themeMode == 0
              ? ThemeMode.system
              : themeMode == 1
                  ? ThemeMode.light
                  : ThemeMode.dark);
          return ThemeModeNotifier(ThemeMode.values[themeMode]);
        },
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    portraitModeOnly();
    getAdData();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    portraitModeOnly();
    getAdData();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void didChangePlatformBrightness() {
    final Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
    if (themeMode == 0) {
      if (brightness == Brightness.dark) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark.copyWith(
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
          ),
        );
      } else {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light.copyWith(
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
          ),
        );
      }
    }
    super.didChangePlatformBrightness();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          final Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
          if (themeMode == 0) {
            if (brightness == Brightness.dark) {
              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle.dark.copyWith(
                  systemNavigationBarColor: Colors.black,
                  systemNavigationBarIconBrightness: Brightness.light,
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: Colors.transparent,
                  statusBarBrightness: Brightness.dark,
                ),
              );
            } else {
              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle.light.copyWith(
                  systemNavigationBarColor: Colors.white,
                  systemNavigationBarIconBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.transparent,
                  statusBarBrightness: Brightness.light,
                ),
              );
            }
          } else if (themeMode == 1) {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle.light.copyWith(
                systemNavigationBarColor: Colors.white,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.light,
              ),
            );
          } else {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle.dark.copyWith(
                systemNavigationBarColor: Colors.black,
                systemNavigationBarIconBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.dark,
              ),
            );
          }
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeModeNotifier>(context);
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result == ConnectivityResult.none) {
        assetsAudioPlayer.stop();
        Future.delayed(Duration(seconds: 3), () {
          Get.off(() => DownloadScreen(), transition: Transition.native);
        });
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          userController.getuser().whenComplete(() {
            Get.off(() => userController.userId != null || userController.isguest.value ? MyBottomNavigationBar() : OnBoardingScreen());
          });
        });
      }
    });
    return ChangeNotifierProvider(
      create: (_) => LocalizationController(),
      child: Consumer(builder: (context, LocalizationController localization, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, abc) {
            return GetMaterialApp(
              translations: AppTranslations(),
              locale: Locale(languagecode!),
              title: 'Musicplayer',
              theme: AppTheme().lightTheme,
              darkTheme: AppTheme().darkTheme,
              themeMode: themeNotifier.getThemeMode(),
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            );
          },
        );
      }),
    );
  }
}
