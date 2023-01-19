// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:labora/theme/color_codes.dart';
// import 'package:labora/view/Push%20Notification/notification_badge.dart';
// import 'package:labora/view/Push%20Notification/push_notification.dart';
// import 'package:overlay_support/overlay_support.dart';
// import 'package:labora/main.dart';
// import '../Push Notification/local_notification_service.dart';



// class IOSplashscreen extends StatefulWidget {
//   const IOSplashscreen({Key? key}) : super(key: key);

//   @override
//   State<IOSplashscreen> createState() => _IOSplashscreenState();
// }


// class _IOSplashscreenState extends State<IOSplashscreen> {
//     late int _totalNotifications;
//   late final FirebaseMessaging _messaging;
//   PushNotification? _notificationInfo;
//    void requestAndRegisterNotification() async {
//     // 1. Initialize the Firebase app
//    await Firebase.initializeApp();

//     // 2. Instantiate Firebase Messaging
//     _messaging = FirebaseMessaging.instance;
//         FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    

//     // 3. On iOS, this helps to take the user permissions
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//       String? token = await _messaging.getToken();
//       print("The token is "+token!);
//       // For handling the received notifications
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         // Parse the message received
//         PushNotification notification = PushNotification(
//           title: message.notification?.title,
//           body: message.notification?.body,
//         );

//         setState(() {
//           _notificationInfo = notification;
//           _totalNotifications++;
//         });
//         if (_notificationInfo != null) {
//           // For displaying the notification as an overlay
//           showSimpleNotification(
//             Text(_notificationInfo!.title!),
//             leading: NotificationBadge(totalNotifications: _totalNotifications),
//             subtitle: Text(_notificationInfo!.body!),
//             background: Colors.cyan.shade700,
//             duration: Duration(seconds: 2),
//           );
//         }
//       });
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }

//   @override
//   void initState() {
//     print('IOS SPlash Called');
//     // TODO: implement initState
//     super.initState();
    
//     //  requestAndRegisterNotification();
//     // _totalNotifications = 0;
//     _navigatetohome();
//   }

//   _navigatetohome() async {
//     await Future.delayed(Duration(milliseconds: 2500), () {});

//     Get.offAllNamed('/homepage');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [splashbackground, splashbackground])),
//         child: Center(
//           child: Image.asset(
//             'assets/img/Applogo.png',
//             height: 166.h,
//             width: 176.w,
//           ),
//         ),
//       ),
//     );
//   }
// }
