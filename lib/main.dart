import 'dart:io';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:gohomy/screen/find_room/room_information/room_information_screen.dart';
import 'package:gohomy/screen/home/home_screen.dart';
import 'package:gohomy/utils/appflyer.dart';
import 'package:gohomy/utils/user_info.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'data/firebase/load_firebase.dart';
import 'data/remote/saha_service_manager.dart';
import 'data/socket/socket.dart';
import 'model/user_login.dart';
import 'screen/profile/service_sell/product_user_screen/product_user_screen.dart';
import 'screen/splash/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  

  await UserInfo().getInitIsRelease();
  await AppFlyer().initAppFlyer();
  UserInfo().loadDataUserSaved();
  SahaServiceManager.initialize();
  await LoadFirebase.initFirebase();

  final directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(UserLoginAdapter());

  SocketUser().connect();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://ba78b2097cc349869dfee7079fcb35a1@o4504693241806848.ingest.sentry.io/4504806254379008';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(
       MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
   MyApp({
    Key? key,
  }) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
 

      


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      title: 'Rencity',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        appBarTheme: const AppBarTheme(),
        primarySwatch: Colors.deepOrange,
        textTheme: GoogleFonts.baloo2TextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.baloo2(textStyle: textTheme.bodyText1),
        ),
        // fontFamily: 'BryabtLG',
        scaffoldBackgroundColor: Colors.white,
      ),
      // getPages: [
      //   GetPage(
      //       name: "/service_sell_screen", page: () => ServiceSellLockScreen()),
      // ],
      home: 
    
      SplashScreen(),
      supportedLocales: const [
        Locale('vi', 'VN'),
      ],
      navigatorObservers:[routeObserver,observer],
    );
  }
}
