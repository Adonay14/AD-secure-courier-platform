// ignore_for_file: avoid_print
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:user_web/constant.dart';
// import 'package:user_web/pages/delivery_address_page.dart';
import 'package:user_web/pages/forgot_passowrd_page.dart';
import 'package:user_web/pages/inbox_page.dart';
import 'package:user_web/pages/parcel_delivery_module/parcel_order_detail_page.dart';
import 'package:user_web/pages/policy_page.dart';
import 'package:user_web/pages/profile_page.dart';
import 'package:user_web/pages/terms_page.dart';
import 'package:user_web/pages/track_order_page.dart';
import 'package:user_web/pages/vouchers_page.dart';
import 'package:user_web/pages/wallet_page.dart';
import 'package:user_web/firebase_options.dart';
import 'pages/about_page.dart';
// import 'Pages/home_page.dart';
import 'pages/faq_page.dart';
import 'pages/login_page.dart';
import 'pages/orders_page.dart';
import 'pages/parcel_delivery_module/parcel_delivery_page.dart';
// import 'pages/restaurant_module/restaurant_flash_sales_page.dart';
import 'pages/signup_page.dart';
import 'pages/track_order_detail_page.dart';
import 'widgets/scaffold_widget.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// requestPermission() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );

//   print('User granted permission: ${settings.authorizationStatus}');
// }

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKeyHome =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await setupFlutterNotifications();
//   showFlutterNotification(message);
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   print('Handling a background message ${message.messageId}');
// }

// /// Create a [AndroidNotificationChannel] for heads up notifications
// late AndroidNotificationChannel channel;

// bool isFlutterLocalNotificationsInitialized = false;

// Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     return;
//   }
//   channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );

//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   /// Create an Android Notification Channel.
//   ///
//   /// We use this channel in the `AndroidManifest.xml` file to override the
//   /// default FCM channel to enable heads up notifications.
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   /// Update the iOS foreground notification presentation options to allow
//   /// heads up notifications.
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   isFlutterLocalNotificationsInitialized = true;
// }

// void showFlutterNotification(RemoteMessage message) {
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   if (notification != null && android != null && !kIsWeb) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,

//           //      one that already exists in example app.
//           icon: 'launch_background',
//         ),
//       ),
//     );
//   } else {
//     print(channel);
//   }
// }

// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
bool isLogged = false;
getAuth() {
  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    if (user == null) {
      isLogged = false;

      print('Your login status is:$isLogged');
    } else {
      isLogged = true;

      print('Your login status is:$isLogged');
    }
  });
}

main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  setPathUrlStrategy();


  await EasyLocalization.ensureInitialized();
  // requestPermission();
  getAuth();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(ProviderScope(
    child: EasyLocalization(
        supportedLocales: const [
          Locale('es', 'ES'),
          Locale('en', 'US'),
          Locale('pt', 'PT'),
          Locale('ar', 'AR'),
          Locale('fr', 'FR'),
          Locale('hi', 'IN'),
        ],
        path: 'assets/languagesFile',
        fallbackLocale: const Locale('en', 'US'),
        child: MyApp(
          savedThemeMode: savedThemeMode,
        )),
  ));
}

class MyApp extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

void initialization() async {
  FlutterNativeSplash.remove();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    // _retrieveToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    return AdaptiveTheme(
        light: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: Colors.blue,
            fontFamily: 'Graphik'),
        dark: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.blue,
            fontFamily: 'Graphik'),
        initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (theme, darkTheme) {
          return GlobalLoaderOverlay(
            // useDefaultLoading: false,
            overlayWidgetBuilder: (_) {
              //ignored progress for the moment
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitCubeGrid(
                      color: appColor,
                      size: 50.0,
                    ),
                    const Gap(10),
                    loadingBool == true
                        ? const Text(networkText)
                        : Text(loadingText)
                  ],
                ),
              );
            },
            child: ScreenUtilInit(
                designSize: const Size(360, 690),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (_, child) {
                  return MaterialApp.router(
                    routerConfig: router,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    debugShowCheckedModeBanner: false,
                    title: 'AD Courier',
                    theme: theme,
                    darkTheme: darkTheme,
                  );
                }),
          );
        });
  }

  final GoRouter router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/parcel-delivery',
      routes: [
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) =>
              const LoginPage(),
        ),
        GoRoute(
          path: '/forgot-password',
          builder: (BuildContext context, GoRouterState state) =>
              const ForgotPasswordPage(),
        ),
        GoRoute(
            path: '/track-order',
            builder: (BuildContext context, GoRouterState state) =>
                const TrackOrderPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/track-order';
              }
            }),
        GoRoute(
          path: '/tracking-detail/:orderID',
          builder: (BuildContext context, GoRouterState state) =>
              TrackOrderDetailPage(orderID: state.pathParameters['orderID']!),
        ),
        GoRoute(
          path: '/signup',
          builder: (BuildContext context, GoRouterState state) =>
              const SignupPage(),
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKeyHome,
          builder: (_, GoRouterState state, child) {
            return ScaffoldWidget(
              body: child,
              path: state.fullPath.toString(),
            );
          },
          routes: [
            GoRoute(
              path: '/parcel-delivery',
              builder: (BuildContext context, GoRouterState state) =>
                  const ParcelDeliveryPage(),
              // redirect: (context, state) {
              //   if (isLogged == false) {
              //     return '/login';
              //   } else {
              //     return '/parcel-delivery';
              //   }
              // }
            ),
            GoRoute(
              path: '/terms',
              builder: (BuildContext context, GoRouterState state) =>
                  const TermsPage(),
            ),
            GoRoute(
              path: '/policy',
              builder: (BuildContext context, GoRouterState state) =>
                  const PolicyPage(),
            ),
            GoRoute(
                path: '/wallet',
                builder: (BuildContext context, GoRouterState state) =>
                    const WalletPage(),
                redirect: (context, state) {
                  if (isLogged == false) {
                    return '/login';
                  } else {
                    return '/wallet';
                  }
                }),
            GoRoute(
                path: '/profile',
                builder: (BuildContext context, GoRouterState state) =>
                    const ProfilePage(),
                redirect: (context, state) {
                  if (isLogged == false) {
                    return '/login';
                  } else {
                    return '/profile';
                  }
                }),
            GoRoute(
                path: '/orders',
                builder: (BuildContext context, GoRouterState state) =>
                    const OrdersPage(),
                redirect: (context, state) {
                  if (isLogged == false) {
                    return '/login';
                  } else {
                    return '/orders';
                  }
                }),
            GoRoute(
                path: '/voucher',
                builder: (BuildContext context, GoRouterState state) =>
                    const VoucherPage(),
                redirect: (context, state) {
                  if (isLogged == false) {
                    return '/login';
                  } else {
                    return '/voucher';
                  }
                }),
            // GoRoute(
            //     path: '/delivery-addresses',
            //     builder: (BuildContext context, GoRouterState state) =>
            //         const DeliveryAddressPage(),
            //     redirect: (context, state) {
            //       if (isLogged == false) {
            //         return '/login';
            //       } else {
            //         return '/delivery-addresses';
            //       }
            //     }),
            GoRoute(
                path: '/inbox',
                builder: (BuildContext context, GoRouterState state) =>
                    const InboxPage(),
                redirect: (context, state) {
                  if (isLogged == false) {
                    return '/login';
                  } else {
                    return '/inbox';
                  }
                }),
            GoRoute(
              path: '/parcel-order-detail/:id',
              builder: (BuildContext context, GoRouterState state) =>
                  ParcelOrderDetail(
                uid: state.pathParameters['id']!,
              ),
            ),
            GoRoute(
              path: '/about',
              builder: (BuildContext context, GoRouterState state) =>
                  const AboutPage(),
            ),
            GoRoute(
              path: '/faq',
              builder: (BuildContext context, GoRouterState state) =>
                  const FaqPage(),
            ),
          ],
        ),
      ]);
}
