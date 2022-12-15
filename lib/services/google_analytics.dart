import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

// MORE LOG EVENTS IN https://pub.dev/packages/firebase_analytics/example

class GoogleAnalytics {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> init() async => await Firebase.initializeApp();

  Future<void> logEvent({
    required String name,
    Map<String, dynamic>? params = const {},
  }) async =>
      await analytics.logEvent(name: name, parameters: params);

  Future<void> setAnalyticsCollectionEnabled(bool enabled) async =>
      await analytics.setAnalyticsCollectionEnabled(enabled);

  Future<void> logLoginEvent() async =>
      await analytics.logLogin(loginMethod: 'login');

  Future<void> logPurchase() async => await analytics.logPurchase(
        currency: 'USD',
        transactionId: 'transaction-id',
      );

  Future<void> logSelectContent() async => await analytics.logSelectContent(
        contentType: 'test content type',
        itemId: 'test item id',
      );
}
