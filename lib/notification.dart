import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('escape_anchovy');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false);

    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  final storage = const FlutterSecureStorage();

  Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    if (status == PermissionStatus.granted) {
      await storage.write(key: 'isAlarmPermissionAllow', value: 'true');
    }
    initialAlarmPermission();
  }

  late bool isAlarmPermissionAllow;

  Future<void> initialAlarmPermission() async {
    isAlarmPermissionAllow =
        await storage.read(key: 'isAlarmPermissionAllow') == 'true';
  }

  // static requestAndroidNotificationPermission() {
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.requestNotificationsPermission();
  // }

  // static requestIOSNotificationPermission() {
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           IOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(alert: true, badge: true);
  // }

  static Future showScheduleNotification({
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('id', 'name',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            showWhen: false);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: const DarwinNotificationDetails(badgeNumber: 1));

    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      title,
      body,
      makeDate(hour, minute),
      notificationDetails,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future cancelNotification() async {
    FlutterLocalNotificationsPlugin localNotification =
        FlutterLocalNotificationsPlugin();
    localNotification.cancelAll();
  }

  static makeDate(h, m) {
    var now = tz.TZDateTime.now(tz.getLocation('Asia/Seoul'));
    var when = tz.TZDateTime(
        tz.getLocation('Asia/Seoul'), now.year, now.month, now.day, h, m);
    if (when.isBefore(now)) {
      return when.add(const Duration(days: 1));
    } else {
      return when;
    }
  }
}
