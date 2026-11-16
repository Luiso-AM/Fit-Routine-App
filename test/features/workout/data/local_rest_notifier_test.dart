import 'package:app_entrenamiento/features/workout/data/local_rest_notifier.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timezone/timezone.dart' as tz;

class _MockPlugin extends Mock implements FlutterLocalNotificationsPlugin {}

class _MockAndroid extends Mock
    implements AndroidFlutterLocalNotificationsPlugin {}

void main() {
  late _MockPlugin plugin;
  late _MockAndroid android;
  late LocalRestNotifier notifier;
  final endsAt = DateTime.utc(2026, 11, 16, 10, 1, 30);

  setUpAll(() {
    registerFallbackValue(const InitializationSettings());
    registerFallbackValue(const NotificationDetails());
    registerFallbackValue(AndroidScheduleMode.exact);
    registerFallbackValue(tz.TZDateTime.utc(2026));
  });

  setUp(() {
    plugin = _MockPlugin();
    android = _MockAndroid();
    notifier = LocalRestNotifier(
      plugin: plugin,
      clock: () => endsAt.subtract(const Duration(seconds: 90)),
    );

    when(() => plugin.initialize(settings: any(named: 'settings')))
        .thenAnswer((_) async => true);
    when(
      () => plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >(),
    ).thenReturn(android);
    when(
      () => plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >(),
    ).thenReturn(null);
    when(android.requestNotificationsPermission).thenAnswer((_) async => true);
    when(android.canScheduleExactNotifications).thenAnswer((_) async => true);
    when(() => plugin.cancel(id: any(named: 'id'))).thenAnswer((_) async {});
    when(
      () => plugin.zonedSchedule(
        id: any(named: 'id'),
        title: any(named: 'title'),
        body: any(named: 'body'),
        scheduledDate: any(named: 'scheduledDate'),
        notificationDetails: any(named: 'notificationDetails'),
        androidScheduleMode: any(named: 'androidScheduleMode'),
      ),
    ).thenAnswer((_) async {});
  });

  (tz.TZDateTime, AndroidScheduleMode) scheduled() {
    final captured = verify(
      () => plugin.zonedSchedule(
        id: LocalRestNotifier.notificationId,
        title: any(named: 'title'),
        body: any(named: 'body'),
        scheduledDate: captureAny(named: 'scheduledDate'),
        notificationDetails: any(named: 'notificationDetails'),
        androidScheduleMode: captureAny(named: 'androidScheduleMode'),
      ),
    ).captured;
    return (captured[0] as tz.TZDateTime, captured[1] as AndroidScheduleMode);
  }

  test('given exact alarms are allowed, when a rest is scheduled, '
      'then an exact notification is set for its end in UTC', () async {
    await notifier.schedule(endsAt);

    final (date, mode) = scheduled();
    expect(date.isAtSameMomentAs(endsAt), isTrue);
    expect(date.location, tz.UTC);
    expect(mode, AndroidScheduleMode.exactAllowWhileIdle);
  });

  test('given exact alarms are not allowed, when a rest is scheduled, '
      'then an inexact notification is set', () async {
    when(android.canScheduleExactNotifications).thenAnswer((_) async => false);

    await notifier.schedule(endsAt);

    expect(scheduled().$2, AndroidScheduleMode.inexactAllowWhileIdle);
  });

  test('given several rests, when scheduled, '
      'then the plugin is initialized and permission asked once', () async {
    await notifier.schedule(endsAt);
    await notifier.schedule(endsAt.add(const Duration(seconds: 15)));
    await notifier.cancel();

    verify(() => plugin.initialize(settings: any(named: 'settings'))).called(1);
    verify(android.requestNotificationsPermission).called(1);
  });

  test('given a failed initialization, when scheduled again, '
      'then initialization is retried', () async {
    when(() => plugin.initialize(settings: any(named: 'settings')))
        .thenThrow(Exception('boom'));
    await expectLater(notifier.schedule(endsAt), throwsException);
    when(() => plugin.initialize(settings: any(named: 'settings')))
        .thenAnswer((_) async => true);

    await notifier.schedule(endsAt);

    verify(() => plugin.initialize(settings: any(named: 'settings'))).called(2);
  });

  test('given a rest that is already over, when scheduled, '
      'then the last notification is cancelled and none is set', () async {
    notifier = LocalRestNotifier(plugin: plugin, clock: () => endsAt);

    await notifier.schedule(endsAt);

    verify(() => plugin.cancel(id: LocalRestNotifier.notificationId)).called(1);
    verifyNever(
      () => plugin.zonedSchedule(
        id: any(named: 'id'),
        title: any(named: 'title'),
        body: any(named: 'body'),
        scheduledDate: any(named: 'scheduledDate'),
        notificationDetails: any(named: 'notificationDetails'),
        androidScheduleMode: any(named: 'androidScheduleMode'),
      ),
    );
  });

  test('given a scheduled rest, when cancelled, '
      'then the rest notification is cancelled', () async {
    await notifier.schedule(endsAt);

    await notifier.cancel();

    verify(() => plugin.cancel(id: LocalRestNotifier.notificationId)).called(2);
  });
}
