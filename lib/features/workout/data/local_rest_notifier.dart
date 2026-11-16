import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../domain/rest_notifier.dart';
import 'rest_notification_strings.dart';

/// [RestNotifier] backed by a scheduled local notification.
///
/// The plugin is initialized on first use, so app startup does not wait
/// for it. Times are scheduled in UTC: a rest is a point in time, so no
/// time zone database is needed.
class LocalRestNotifier implements RestNotifier {
  LocalRestNotifier([FlutterLocalNotificationsPlugin? plugin])
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  /// The rest notification is unique: scheduling one replaces the last.
  static const int notificationId = 1001;
  static const String channelId = 'rest_timer';

  static const NotificationDetails _details = NotificationDetails(
    android: AndroidNotificationDetails(
      channelId,
      RestNotificationStrings.channelName,
      channelDescription: RestNotificationStrings.channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.alarm,
    ),
    iOS: DarwinNotificationDetails(),
  );

  final FlutterLocalNotificationsPlugin _plugin;
  Future<void>? _ready;

  /// A failed initialization is retried on the next call.
  Future<void> _ensureReady() => _ready ??= _initializeOrReset();

  Future<void> _initializeOrReset() async {
    try {
      await _initialize();
    } catch (_) {
      _ready = null;
      rethrow;
    }
  }

  Future<void> _initialize() async {
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        // Permission is asked when the first rest starts, not at launch.
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestSoundPermission: false,
          requestBadgePermission: false,
        ),
      ),
    );
    await _android?.requestNotificationsPermission();
    await _ios?.requestPermissions(alert: true, sound: true);
  }

  AndroidFlutterLocalNotificationsPlugin? get _android => _plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  IOSFlutterLocalNotificationsPlugin? get _ios => _plugin
      .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin
      >();

  /// Exact alarms need a permission the user may not grant (Android 14+).
  /// Without it the notification can arrive a little late; the timer on
  /// screen is still exact.
  Future<AndroidScheduleMode> _scheduleMode() async {
    final exact = await _android?.canScheduleExactNotifications() ?? true;
    return exact
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;
  }

  @override
  Future<void> schedule(DateTime endsAt) async {
    await _ensureReady();
    await _plugin.cancel(id: notificationId);
    await _plugin.zonedSchedule(
      id: notificationId,
      title: RestNotificationStrings.title,
      body: RestNotificationStrings.body,
      scheduledDate: tz.TZDateTime.from(endsAt.toUtc(), tz.UTC),
      notificationDetails: _details,
      androidScheduleMode: await _scheduleMode(),
    );
  }

  @override
  Future<void> cancel() async {
    await _ensureReady();
    await _plugin.cancel(id: notificationId);
  }
}
