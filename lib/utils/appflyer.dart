import 'package:appsflyer_sdk/appsflyer_sdk.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppFlyer {
  static final AppFlyer _singleton = AppFlyer._internal();

  AppsflyerSdk? _appsflyerSdk;

  factory AppFlyer() {
    return _singleton;
  }

  AppFlyer._internal();

  Future<void> initAppFlyer() async {
    final AppsFlyerOptions options = AppsFlyerOptions(
        afDevKey: 'XpLuXG2fMjgrvzDsBJgwrZ',
        appId: '6443961326',
        showDebug: true,
        timeToWaitForATTUserAuthorization: 15);
    _appsflyerSdk = AppsflyerSdk(options);
    _appsflyerSdk!.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: false,
        registerOnDeepLinkingCallback: true);
  }
}
