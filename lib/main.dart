// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eat_well/api-handler/api-handler.dart';
import 'package:eat_well/api-handler/api-repo.dart';
import 'package:eat_well/route/app_pages.dart';
import 'package:eat_well/theme/theme.dart';
import 'package:eat_well/theme/theme_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:eat_well/widgets/Easy_loading.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// Future firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      ));
    }
  }

  // await Firebase.initializeApp();
  // LocalNotificationService.initialize();

  /// below three lines are for backgound notification
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  // await PushNotificationService().setupInteractedMessage();
  // RemoteMessage? initialMessage =
  //     await FirebaseMessaging.instance.getInitialMessage();
  // if (initialMessage != null) {
  //   // App received a notification when it was killed}
  // }
  // final PendingDynamicLinkData? initialLink =
  //   await FirebaseDynamicLinks.instance.getInitialLink();

  ///////////////////// finish dynamic link code

  Get.put(ApiBaseHelper(), permanent: true);
  Get.put(ApiRepository(Get.find()));
  Get.put(InitialStatusController(Get.find()));

  //
  await EasyLocalization.ensureInitialized();

  // await EasyLocalization.ensureInitialized();

  // await Firebase.initializeApp();
  EasyLoader().configLoading();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white.withOpacity(0.0),
    // navigation bar color
    statusBarColor: Colors.white.withOpacity(0.0), // status bar color
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(EasyLocalization(
            startLocale: const Locale('en'),
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
              // Locale('ur'),
              // Locale('hi'),
              // Locale('bn')
            ],
            path: 'assets/lang', // <-- change the path of the translation files
            fallbackLocale: const Locale('en'),
            // child: MyApp(initialLink: initialLink))
            child: MyApp())
        // )
        );
  });
}

///Device registration id Code
// String deviceTokenToSendPushNotification = '';
// Future<void> getDeviceTokenToSendNotification() async {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//   _fcm.subscribeToTopic('all');
//   final token = await _fcm.getToken();
//   deviceTokenToSendPushNotification = token.toString();
//   print("Device Token Value $deviceTokenToSendPushNotification");
//   final box = GetStorage();
//   box.write('deviceregistrationID', deviceTokenToSendPushNotification);
//   print('boxx value is${box.read('deviceregistrationID')}');
// }

class MyApp extends StatefulWidget {
  // final PendingDynamicLinkData? initialLink;
  // const MyApp({Key? key, this.initialLink}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var token;
  InitialStatusController controller = Get.find<InitialStatusController>();
  // String? path;
  final box = GetStorage();

  @override
  initState() {
    // if (widget.initialLink != null) {
    //   path = widget.initialLink!.link.path;
    //   String? string = path;
    //   var result = string!.substring(1);
    //   homcon.referalCode(result);
    //   print(homcon.referalCode.value);
    // }
    // FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    //   path = dynamicLinkData.link.path;
    //   String? string = path;
    //   var result = string!.substring(1);
    //   homcon.referalCode(result);
    //   print(homcon.referalCode.value);
    //   var loginstatus = box.read('token');
    //   if (loginstatus == null) {
    //     Get.offAllNamed('/signup', arguments: {'editrequest': false});
    //   } else {
    //     print('Please Logout to see changes');
    //   }
    // }).onError((error) {
    //   // Handle errors
    // });
    super.initState();
    // getDeviceTokenToSendNotification();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        defaultTransition: Transition.cupertino,
        locale: context.locale,
        title: "EatWell",
        initialRoute: controller.loginToken.value.toString() == ''
            ? AppPages.INITIAL
            : AppPages.DASHBOARD,
        builder: EasyLoading.init(),
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        // initialBinding: InitialBinding(),

        theme: Themes.light,
        // darkTheme: Themes.dark,
        themeMode: ThemeService().theme,
      ),
      designSize: const Size(360, 640),
    );
  }
}
