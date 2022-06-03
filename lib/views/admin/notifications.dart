

// import 'package:flutter/material.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:timezone/timezone.dart' as tz;
// // import 'package:timezone/data/latest.dart' as tz;

// // class NotificationService {
// //   static final NotificationService _notificationService = NotificationService._internal();

// //   factory NotificationService() {
// //     return _notificationService;
// //   }

// //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// //   NotificationService._internal();

// //   Future<void> initNotification() async {
// //     final AndroidInitializationSettings initializationSettingsAndroid =
// //     AndroidInitializationSettings('@drawable/ic_stat_add_alert');

// //     final IOSInitializationSettings initializationSettingsIOS =
// //     IOSInitializationSettings(
// //       requestAlertPermission: false,
// //       requestBadgePermission: false,
// //       requestSoundPermission: false,
// //     );

// //     final InitializationSettings initializationSettings =
// //     InitializationSettings(
// //       android: initializationSettingsAndroid,
// //       iOS: initializationSettingsIOS
// //     );

// //     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
// //   }

// //   Future<void> showNotification(int id, String title, String body, int seconds) async {
// //     await flutterLocalNotificationsPlugin.zonedSchedule(
// //       id,
// //       title,
// //       body,
// //       tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
// //       const NotificationDetails(
// //         android: AndroidNotificationDetails(
// //           'main_channel',
// //           'Main Channel',

// //           importance: Importance.max,
// //           priority: Priority.max,
// //           icon: '@drawable/ic_stat_add_alert'
// //         ),
// //         iOS: IOSNotificationDetails(
// //           sound: 'default.wav',
// //           presentAlert: true,
// //           presentBadge: true,
// //           presentSound: true,
// //         ),
// //       ),
// //       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
// //       androidAllowWhileIdle: true,
// //     );
// //   }

// //   Future<void> cancelAllNotifications() async {
// //     await flutterLocalNotificationsPlugin.cancelAll();
// //   }
// // }
// // class NotificationService {
// //   static final _notifications = FlutterLocalNotificationsPlugin();
// //   static Future _notificationDetails() async {
// //     return NotificationDetails(
// //       android: AndroidNotificationDetails('channel id', 'channel name',
// //           importance: Importance.max,
// //           priority: Priority.max,
// //           playSound: true),
// //           iOS: IOSNotificationDetails(),
// //     );
// //   }

// //   static Future showNotification({
// //     int id = 0,
// //     String? title,
// //     String? body,

// //   }) async =>
// //       _notifications.show(
// //         id,
// //         title,
// //         body,
// //         await _notificationDetails(),

// //       );
// // }

// class notification extends StatefulWidget {
//   const notification({Key? key}) : super(key: key);

//   @override
//   State<notification> createState() => _notificationState();
// }

// class _notificationState extends State<notification> {
//   var localnotifications = FlutterLocalNotificationsPlugin();
//   @override
//   void initState() {
//     super.initState();
//     var androidInitialize = new AndroidInitializationSettings('ic_luncher');
//     var iOSIniatilized = new IOSInitializationSettings();
//     var initializationSettings = new InitializationSettings(
//         android: androidInitialize, iOS: iOSIniatilized);
//     localnotifications = new FlutterLocalNotificationsPlugin();
//     localnotifications.initialize(initializationSettings);
//   }

//   Future<void>_showNotification() async {
//     var androiddetails = new AndroidNotificationDetails(
//         'channel id', 'channel name',
//         importance: Importance.high);
//     var generalnoifications = new NotificationDetails(android: androiddetails);
//     await localnotifications.show(0, 'not', 'jsj', generalnoifications);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showNotification();
//         },
//         child: Icon(Icons.notification_add),
//       ),
//     );
//   }
// }


// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;


// class NotificationService {
//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService;
//   }

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   NotificationService._internal();

//   Future<void> initNotification() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings("ic_launcher");
//     const IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsIOS);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> showNotification(
//       {required int id,
//       required String title,
//       required String body,}) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         id,
//         title,
//         body,
//         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 1)),         

//         const NotificationDetails(
//             android: AndroidNotificationDetails('main_channel', "Main_channel",
//                 importance: Importance.max, priority: Priority.max),
//             iOS: IOSNotificationDetails(
//               sound: 'default.wav',
//               presentAlert: true,
//               presentBadge: true,
//               presentSound: true,
//             )),
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         androidAllowWhileIdle: true);
//   }

//   Future<void> cancelAllNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
static final NotificationService _notificationService =
	NotificationService._internal();

factory NotificationService() {
	return _notificationService;
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
	FlutterLocalNotificationsPlugin();

NotificationService._internal();

Future<void> initNotification() async {
	
	// Android initialization
	final AndroidInitializationSettings initializationSettingsAndroid =
		AndroidInitializationSettings('@drawable/ic_launcher');

	// ios initialization
	final IOSInitializationSettings initializationSettingsIOS =
		IOSInitializationSettings(
	requestAlertPermission: false,
	requestBadgePermission: false,
	requestSoundPermission: false,
	);

	final InitializationSettings initializationSettings =
		InitializationSettings(
			android: initializationSettingsAndroid,
			iOS: initializationSettingsIOS);
	// the initialization settings are initialized after they are setted
	await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> showNotification(int id, String title, String body) async {
	await flutterLocalNotificationsPlugin.zonedSchedule(
	id,
	title,
	body,
	tz.TZDateTime.now(tz.local).add(Duration(
		seconds: 1)), //schedule the notification to show after 2 seconds.
	const NotificationDetails(
		
		// Android details
		android: AndroidNotificationDetails('main_channel', 'Main Channel',
			channelDescription: "hello",
			importance: Importance.max,
			priority: Priority.max),
		// iOS details
		iOS: IOSNotificationDetails(
		
		presentAlert: true,
		presentBadge: true,
		presentSound: true,
		),
	),
	
	// Type of time interpretation
	uiLocalNotificationDateInterpretation:
		UILocalNotificationDateInterpretation.absoluteTime,
	androidAllowWhileIdle:
		true, // To show notification even when the app is closed
	);
}
}

