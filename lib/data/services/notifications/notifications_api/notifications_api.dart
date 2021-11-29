import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static Future showNotifications({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notification.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel Id',
        'channel Name',
        channelDescription: 'channel description',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }
}
