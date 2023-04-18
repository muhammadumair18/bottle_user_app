import 'package:bottle_user_app/generated/locales.g.dart';
import 'package:bottle_user_app/helpers/helpers.dart';
import 'package:bottle_user_app/view/screens/screen_user_home_page.dart';
import 'package:bottle_user_app/view/screens/screen_user_splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:camera/camera.dart';






AndroidNotificationChannel channel= AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description : 'This channel is used for important notifications.', // description
  importance: Importance.max,
);

// flutter local notification
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//--------------------------------------------------------------------------

Future<void> _basckgroundMessageHandler(RemoteMessage message) async{
  print('Backgroundhandler');
  print('${message.data['type']}');
  print('${message.data['content']}');
  if(message.notification != null){
    print(message.notification!.title);
    print(message.notification!.body);
  }
  Firebase.initializeApp();
  //FlutterLocalNotification.show(..... So on will not be written here
  //it will send two messages
}


List<CameraDescription> cameras=[];

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  registraiontokenformessaging= (await FirebaseMessaging.instance.getToken())!;
  FirebaseMessaging.onBackgroundMessage(_basckgroundMessageHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  print('registraiontokenformessaging       ${registraiontokenformessaging}');
  runApp(Phoenix(child: const MyApp()));

  cameras = await availableCameras();
  String? gettingtoken = await FirebaseMessaging.instance.getToken();
  print('Messgaing token         ${gettingtoken}');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    // FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen((message){
      // RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
      print(message.data);
      if(message.notification != null){
        print(message.notification!.title);
        print(message.notification!.body);
      }
      // The missing is in the helpers
      flutterLocalNotificationsPlugin.show(
        message.data.hashCode,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              priority: Priority.high,
              icon: '@mipmap/launcher_icon'
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
          ),
        ),
      );
    });
  }

  void _handleMessage(RemoteMessage message) {
    print('handle messgae');
    if (message.data != null) {
      print(message.notification!.title);
      print(message.notification!.body);
      //
      print('${message.data['type']}');
      print('${message.data['content']}');
      final routeFromMessage = message.data["route"];
      Navigator.of(context).pushNamed(routeFromMessage);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupInteractedMessage();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        translationsKeys: AppTranslation.translations,

        locale: englishlanguage==true?Locale('en'):Locale('ur'),
        debugShowCheckedModeBanner: false,
        home:Directionality(
          textDirection: TextDirection.ltr,
          child: FirebaseAuth.instance.currentUser?.uid != null?ScreenUserHomePage():ScreenUserSplash(),
        ),
        // FirebaseAuth.instance.currentUser!=null?ScreenUserHomePage():ScreenUserSplash()

        theme: ThemeData(
            appBarTheme:
                AppBarTheme(backgroundColor: Colors.white, elevation: 0.5)),
      );
    });
  }
}
