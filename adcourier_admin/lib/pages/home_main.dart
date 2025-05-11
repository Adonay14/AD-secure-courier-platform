import 'package:admin/Widget/languageview.dart';
import 'package:admin/providers/auth_provider.dart';
import 'package:admin/providers/home_main_provider.dart';
import 'package:admin/utils/theme/theme.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../Widget/drawer.dart';

class HomePageMain extends ConsumerStatefulWidget {
  final Widget body;
  final String url;
  const HomePageMain({
    super.key,
    required this.body,
    required this.url,
  });
  @override
  ConsumerState<HomePageMain> createState() => _HomePageMainState();
}

class _HomePageMainState extends ConsumerState<HomePageMain> {
  var logger = Logger();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProviderProvider);
    final themeNotifier = ref.watch(themeNotifierProviderProvider.notifier);
    final firebaseDetails = ref.watch(firebaseDetailsProvider);
    final logout = ref.read(authProviderProvider.notifier);
    final themeNotifierChange = Provider.of<ThemeNotifier>(context);
    bool themeListener = ref.watch(themeListenerProvider);
    logger.d(themeListener);
    return themeMode.when(error: (e, rr) {
      return const Text('');
    }, loading: () {
      return const Text('loading...');
    }, data: (s) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: s ? Colors.white12 : Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 1,
          actions: [
            themeMode.when(
              data: (isLightTheme) => IconButton(
                onPressed: () {
                  themeNotifier.toggleTheme(!isLightTheme, themeNotifierChange);
                  // ref.watch(
                  //     changeThemeProvider(isLightTheme, themeNotifierChange));
                },
                color: Theme.of(context).iconTheme.color,
                icon: isLightTheme
                    ? Icon(
                        Icons.sunny,
                        size:
                            MediaQuery.of(context).size.width >= 1100 ? 20 : 15,
                      )
                    : Icon(
                        Icons.radio_button_checked,
                        size:
                            MediaQuery.of(context).size.width >= 1100 ? 20 : 15,
                      ),
              ),
              loading: () =>
                  const CircularProgressIndicator(), // Show a loading indicator while loading
              error: (error, stack) => const Icon(
                  Icons.error), // Show an error icon in case of an error
            ),
            IconButton(
                color: Theme.of(context).iconTheme.color,
                onPressed: () {
                  context.go('/notifications');
                },
                icon: Icon(
                  Icons.notifications_outlined,
                  size: MediaQuery.of(context).size.width >= 1100 ? 20 : 15,
                )),
            TextButton(
              child: Icon(
                Icons.language,
                size: MediaQuery.of(context).size.width >= 1100 ? 20 : 15,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: SizedBox(
                            width: MediaQuery.of(context).size.width >= 1100
                                ? MediaQuery.of(context).size.width / 3
                                : MediaQuery.of(context).size.width / 1.3,
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: const LanguageView()),
                      );
                    });
              },
            ),
            firebaseDetails.when(
              data: (details) {
                return DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    customButton: SizedBox(
                      width:
                          MediaQuery.of(context).size.width >= 1100 ? 40 : 40,
                      height:
                          MediaQuery.of(context).size.width >= 1100 ? 40 : 30,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(details['ProfilePic']!),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: 8,
                      offset: const Offset(0, 8),
                    ),
                    items: <String>[
                      'Profile'.tr(),
                      'Settings'.tr(),
                      'Log Out'.tr(),
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) async {
                      if (value == 'Log Out'.tr()) {
                        logout.logout();
                        if (context.mounted) {
                          // Navigate to the login page or another appropriate page
                          Flushbar(
                            flushbarPosition: FlushbarPosition.TOP,
                            title: "Notification",
                            message: "Logout successful",
                            duration: const Duration(seconds: 1),
                          ).show(context).then((v) {
                            context.go('/login');
                          });
                        }
                      } else if (value == 'Profile'.tr()) {
                        context.go('/profile');
                      } else {
                        context.go('/settings');
                      }
                    },
                  ),
                );
              },
              loading: () => const SizedBox(),
              error: (err, stack) => Text('Error: $err'),
            ),
            const SizedBox(width: 30),
          ],
          title: MediaQuery.of(context).size.width >= 1100
              ? const SizedBox()
              : Text(
                  'Admin Dashboard',
                  style: TextStyle(
                      color: Theme.of(context).iconTheme.color, fontSize: 12),
                  textAlign: TextAlign.start,
                ).tr(),
          leadingWidth: MediaQuery.of(context).size.width >= 1100 ? 200 : 50,
          leading: MediaQuery.of(context).size.width >= 1100
              ? Center(
                  child: Text(
                    'Admin Dashboard',
                    style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                )
              : InkWell(
                  onTap: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    color: Theme.of(context).iconTheme.color,
                  )),
        ),
        drawer: SideMenu(url: widget.url),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MediaQuery.of(context).size.width >= 1100
                  ? Expanded(child: SideMenu(url: widget.url))
                  : const SizedBox(),
              Expanded(
                flex: 5,
                child: widget.body,
              ),
            ],
          ),
        ),
      );
    });
  }
}
