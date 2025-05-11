import 'package:admin/constance.dart';
import 'package:admin/firebase_options.dart';
import 'package:admin/models/auth_model.dart';
import 'package:admin/pages/3rd%20party%20settings/mail_settings.dart';
import 'package:admin/pages/3rd%20party%20settings/payment_gateway.dart';
import 'package:admin/pages/3rd%20party%20settings/sms_settings.dart';
import 'package:admin/pages/Bulk%20messages/bulk_sms_page.dart';
import 'package:admin/pages/Bulk%20messages/bulk_whatsapp_page.dart';
import 'package:admin/pages/general%20settings/bussiness_settings.dart';
// import 'package:admin/pages/general%20settings/delivery_settings.dart';
import 'package:admin/pages/general%20settings/social_settings.dart';
import 'package:admin/pages/legal%20settings/about_us.dart';
import 'package:admin/pages/legal%20settings/faq.dart';
// import 'package:admin/pages/legal%20settings/faq.dart';
import 'package:admin/pages/legal%20settings/privacy_policy.dart';
import 'package:admin/pages/legal%20settings/terms_and_conditions.dart';
//import 'package:admin/pages/pickup_address_page.dart';
import 'package:admin/pages/Bulk%20messages/push_notifications_page.dart';
import 'package:admin/pages/withdrawal_request.dart';
import 'package:admin/utils/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide ChangeNotifierProvider, Provider;
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:admin/pages/home_main.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:ripple_wave/ripple_wave.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'pages/categories settings/parcel_categories.dart';
import 'pages/Bulk messages/bulk_email_page.dart';
import 'pages/profiles settings/app_settings.dart';
import 'pages/profiles settings/profile.dart';
import 'pages/reports page/orders_report_page.dart';
import 'pages/reports page/users_report_pages.dart';
import 'pages/users settings/riders_page.dart';
import 'pages/users settings/users_page.dart';
import 'pages/coupon_page.dart';
import 'pages/feeds.dart';
import 'pages/home.dart';
import 'pages/login/login.dart';
import 'pages/notifications.dart';
import 'pages/orders.dart';
import 'pages/withdrawal_request_completed.dart';
import 'utils/theme/theme_data.dart';
import 'package:sizer/sizer.dart';

int? initScreen;
bool? seen;
String? newPassword;
String? adminUsername;
String? adminImage;
num? commission;

updateAdmin() {
  FirebaseFirestore.instance
      .collection('Admin')
      .doc('Admin')
      .get()
      .then((value) {
    if (!value.exists) {
      defaultUpdate();
    }
  });
}

defaultUpdate() {
  if (newPassword == null && adminImage == null && adminUsername == null) {
    FirebaseFirestore.instance.collection('Admin').doc('Admin').set({
      'password': '123456',
      'ProfilePic': 'https://img.icons8.com/officel/2x/person-male.png',
      'username': 'admin123@gmail.com',
      'commission': 0,
      'ParcelID': 0,
      'Delivery Fee': 0,
      'orderID': 0
    });

    // FirebaseFirestore.instance
    //     .collection('Product Slide')
    //     .doc('Product Slide')
    //     .set({
    //   'Product Slide 1': '',
    //   'Product Slide 2': '',
    //   'Product Slide 3': '',
    //   'Product Slide 4': '',
    //   'Product Slide 5': ''
    // });
  }
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');
AuthModel? user;
var logger = Logger();
Future<void> _loadUserData() async {
  final box = GetStorage();

  final userJson = box.read('user');
  logger.d('result $userJson');
  if (userJson != null) {
    // var userMap = jsonDecode(userJson);
    // setState(() {
    user = AuthModel.fromMap(userJson);

    // });
  }
}

listenToUser() {
  final box = GetStorage();
  box.listenKey('user', (value) {
    if (value == null) {
      user = null;
    } else {
      _loadUserData();
    }
  });
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // var prefsTheme = await SharedPreferences.getInstance();
  // var lightModeOn = prefsTheme.getBool('lightMode') ?? true;
  await GetStorage.init().then((v) {
    _loadUserData();
  });
  final box = GetStorage();
  var lightModeOn = box.read('lightMode') ?? true;
  listenToUser();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
    options: DefaultFirebaseOptions.currentPlatform,
  );

  updateAdmin();

  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeNotifier>.value(
              value: ThemeNotifier(lightModeOn ? lightTheme : darkTheme)),
        ],
        child: EasyLocalization(
            supportedLocales: const [
              Locale('es', 'ES'),
              Locale('en', 'US'),
              Locale('pt', 'PT'),
              Locale('ar', 'AR'),
              Locale('fr', 'FR'),
              Locale('hi', 'IN'),
              Locale('ru', 'RU'),
            ],
            path: 'assets/languagesFile',
            fallbackLocale: const Locale('en', 'US'),
            child: const MyApp()),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
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
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Sizer(builder: (context, orientation, deviceType) {
      return GlobalLoaderOverlay(
        closeOnBackButton: true,
        duration: Durations.medium4,
        reverseDuration: Durations.medium4,
        overlayColor: Colors.grey.withValues(alpha: 0.8),
        overlayWidgetBuilder: (_) {
          //ignored progress for the moment
          return RippleWave(
            waveCount: 0,
            color: Colors.transparent,
            repeat: true,
            child: CircleAvatar(
              minRadius: 50,
              maxRadius: 50,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(child: Image.asset(iconLoader)),
              ),
            ),
          );
        },
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: adminTitle,
          theme: themeNotifier.getTheme(),
          // theme: ThemeData(
          //   primaryColor: Colors.blue,
          //   textTheme: GoogleFonts.robotoTextTheme(
          //     Theme.of(context).textTheme,
          //   ),
          // ),
        ),
      );
    });
  }

  final GoRouter router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/login',
      routes: [
        // GoRoute(
        //     path: '/login',
        //     builder: (BuildContext context, GoRouterState state) =>
        //         const Login(),
        //     redirect: (context, state) {
        //       if (user == null) {
        //         return '/login';
        //       } else {
        //         return '/';
        //       }
        //     }),
        GoRoute(
            path: '/login',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const Login(),
                transitionDuration: const Duration(milliseconds: 1500),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // Change the opacity of the screen using a Curve based on the the animation's
                  // value
                  return FadeTransition(
                    opacity:
                        CurveTween(curve: Curves.easeInOut).animate(animation),
                    child: child,
                  );
                },
              );
            },
            redirect: (context, state) {
              if (user == null) {
                return '/login';
              } else {
                return '/';
              }
            }),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (_, GoRouterState state, child) {
            var logger = Logger();
            logger.d('route url is ${state.fullPath}');
            return HomePageMain(
              url: state.fullPath!,
              body: child,
            );
          },
          routes: [
            // GoRoute(
            //     path: '/',
            //     builder: (BuildContext context, GoRouterState state) =>
            //         const HomePage(),
            //     redirect: (context, state) {
            //       if (user == null) {
            //         return '/login';
            //       } else {
            //         return '/';
            //       }
            //     }),
            GoRoute(
                path: '/',
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: const HomePage(),
                    transitionDuration: const Duration(milliseconds: 1500),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      // Change the opacity of the screen using a Curve based on the the animation's
                      // value
                      return FadeTransition(
                        opacity: CurveTween(curve: Curves.easeInOut)
                            .animate(animation),
                        child: child,
                      );
                    },
                  );
                },
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/';
                  }
                }),
            GoRoute(
                path: '/bulk-email',
                builder: (BuildContext context, GoRouterState state) =>
                    const BulkEmailPage(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/bulk-email';
                  }
                }),

            GoRoute(
                path: '/withdrawal-requests',
                builder: (BuildContext context, GoRouterState state) =>
                    const WithdrawalRequestPage(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/withdrawal-requests';
                  }
                }),

            GoRoute(
                path: '/completed-transactions',
                builder: (BuildContext context, GoRouterState state) =>
                    const WithdrawalRequestCompletedPage(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/completed-transactions';
                  }
                }),
            GoRoute(
                path: '/bulk-sms',
                builder: (BuildContext context, GoRouterState state) =>
                    const BulkSmsPage(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/bulk-sms';
                  }
                }),
            GoRoute(
                path: '/bulk-whatsapp',
                builder: (BuildContext context, GoRouterState state) =>
                    const BulkWhatsappPage(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/bulk-whatsapp';
                  }
                }),
            GoRoute(
                path: '/push-notifications',
                builder: (BuildContext context, GoRouterState state) =>
                    const PushNotificationPage(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/push-notifications';
                  }
                }),

            GoRoute(
                path: '/coupon',
                builder: (BuildContext context, GoRouterState state) =>
                    const CouponPage(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/coupon';
                  }
                }),
            // GoRoute(
            //     path: '/pickup-address',
            //     builder: (BuildContext context, GoRouterState state) =>
            //         const PickupAddressPage(),
            //     redirect: (context, state) {
            //       if (user == null) {
            //         return '/login';
            //       } else {
            //         return '/pickup-address';
            //       }
            //     }),
            GoRoute(
                path: '/users-report',
                builder: (BuildContext context, GoRouterState state) =>
                    const UsersReportPage(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/users-report';
                  }
                }),

            GoRoute(
                path: '/orders-report',
                builder: (BuildContext context, GoRouterState state) =>
                    const OrdersReportPage(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/orders-report';
                  }
                }),
            GoRoute(
                path: '/parcel-categories',
                builder: (context, state) => const ParcelCategories(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/parcel-categories';
                  }
                }),
            GoRoute(
                path: '/riders',
                builder: (context, state) => const Riders(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/riders';
                  }
                }),
            GoRoute(
                path: '/settings',
                builder: (context, state) => const AppSettings(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/settings';
                  }
                }),
            // GoRoute(
            //     path: '/edit-profile',
            //     builder: (context, state) => const EditProfile(),
            //     redirect: (context, state) {
            //       if (user == null) {
            //         return '/login';
            //       } else {
            //         return '/edit-profile';
            //       }
            //     }),
            GoRoute(
                path: '/profile',
                builder: (context, state) => const Profile(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/profile';
                  }
                }),
            GoRoute(
                path: '/users',
                builder: (context, state) => const Users(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/users';
                  }
                }),
            GoRoute(
                path: '/feeds',
                builder: (context, state) => const Feeds(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/feeds';
                  }
                }),
            GoRoute(
                path: '/notifications',
                builder: (context, state) => const Notifications(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/notifications';
                  }
                }),
            GoRoute(
                path: '/orders',
                builder: (context, state) => const Orders(),
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/orders';
                  }
                }),

            // GoRoute(
            //     path: '/reviews',
            //     builder: (context, state) => const Reviews(),
            //     redirect: (context, state) {
            //       if (user == null) {
            //         return '/login';
            //       } else {
            //         return '/reviews';
            //       }
            //     }),

            GoRoute(
                path: '/business-settings',
                builder: (context, state) {
                  // var prod = state.extra as ProductsModel;
                  return const BussinessSettings(
                      // productsModel: prod,
                      );
                },
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/business-settings';
                  }
                }),
            GoRoute(
                path: '/socials-settings',
                builder: (context, state) {
                  // var prod = state.extra as ProductsModel;
                  return const SocialSettings(
                      // productsModel: prod,
                      );
                },
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/socials-settings';
                  }
                }),
            // GoRoute(
            //     path: '/delivery-settings',
            //     builder: (context, state) {
            //       // var prod = state.extra as ProductsModel;
            //       return const DeliverySettings(
            //           // productsModel: prod,
            //           );
            //     },
            //     redirect: (context, state) {
            //       if (user == null) {
            //         return '/login';
            //       } else {
            //         return '/delivery-settings';
            //       }
            //     }),
            GoRoute(
                path: '/privacy-policy',
                builder: (context, state) {
                  // var prod = state.extra as ProductsModel;
                  return const PrivacyPolicy(
                      // productsModel: prod,
                      );
                },
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/privacy-policy';
                  }
                }),
            GoRoute(
                path: '/terms-and-conditions',
                builder: (context, state) {
                  // var prod = state.extra as ProductsModel;
                  return const TermsAndConditions(
                      // productsModel: prod,
                      );
                },
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/terms-and-conditions';
                  }
                }),
            GoRoute(
                path: '/about-us',
                builder: (context, state) {
                  // var prod = state.extra as ProductsModel;
                  return const AboutUs(
                      // productsModel: prod,
                      );
                },
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/about-us';
                  }
                }),
            GoRoute(
                path: '/faq',
                builder: (context, state) {
                  // var prod = state.extra as ProductsModel;
                  return const FaqPage(
                      // productsModel: prod,
                      );
                },
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/faq';
                  }
                }),
            // GoRoute(
            //     path: '/faq',
            //     builder: (context, state) {
            //       // var prod = state.extra as ProductsModel;
            //       return const Faq(
            //           // productsModel: prod,
            //           );
            //     },
            //     redirect: (context, state) {
            //       if (user == null) {
            //         return '/login';
            //       } else {
            //         return '/faq';
            //       }
            //     }),
            GoRoute(
                path: '/payment-gateway',
                builder: (context, state) {
                  // var prod = state.extra as ProductsModel;
                  return const PaymentGateway(
                      // productsModel: prod,
                      );
                },
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/payment-gateway';
                  }
                }),
            GoRoute(
                path: '/sms-settings',
                builder: (context, state) {
                  // var prod = state.extra as ProductsModel;
                  return const SmsSettings(
                      // productsModel: prod,
                      );
                },
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/sms-settings';
                  }
                }),
            GoRoute(
                path: '/mail-settings',
                builder: (context, state) {
                  // var prod = state.extra as ProductsModel;
                  return const MailSettings(
                      // productsModel: prod,
                      );
                },
                redirect: (context, state) {
                  if (user == null) {
                    return '/login';
                  } else {
                    return '/mail-settings';
                  }
                }),
          ],
        ),
      ]);
}
