import 'package:appsflyer_sdk/appsflyer_sdk.dart';

// OFFICIAL SUPPORT IN https://pub.dev/packages/appsflyer_sdk

String DEV_KEY = "";
String APP_ID = "";
bool IN_DEBUG = true;

class AppsFlyerAnalytics {
  late AppsflyerSdk _appsflyerSdk;

  Future<void> init() async {
    final AppsFlyerOptions options = AppsFlyerOptions(
      afDevKey: DEV_KEY,
      //appId: APP_ID,
      showDebug: IN_DEBUG,
    );

    _appsflyerSdk = AppsflyerSdk(options);

    _appsflyerSdk.onAppOpenAttribution(
        (res) => print("onAppOpenAttribution res: " + res.toString()));
    _appsflyerSdk.onInstallConversionData(
        (res) => print("onInstallConversionData res: " + res.toString()));

    _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
      switch (dp.status) {
        case Status.FOUND:
          print(dp.deepLink?.toString());
          print("deep link value: ${dp.deepLink?.deepLinkValue}");
          break;
        case Status.NOT_FOUND:
          print("deep link not found");
          break;
        case Status.ERROR:
          print("deep link error: ${dp.error}");
          break;
        case Status.PARSE_ERROR:
          print("deep link status parsing error");
          break;
      }
      print("onDeepLinking res: " + dp.toString());
    });

    _appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: false,
      registerOnDeepLinkingCallback: true,
    );
  }

  Future<bool?> logEvent(String eventName, Map eventValues) async =>
      await _appsflyerSdk.logEvent(eventName, eventValues);
}
