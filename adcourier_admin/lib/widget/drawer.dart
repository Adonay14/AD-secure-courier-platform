// import 'dart:io';
import 'package:admin/providers/home_main_provider.dart';
import 'package:admin/widget/bulk_drawer.dart';
import 'package:admin/widget/business_drawer.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hovering/hovering.dart';

class SideMenu extends ConsumerStatefulWidget {
  const SideMenu({super.key, required this.url});
  final String url;
  @override
  ConsumerState<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends ConsumerState<SideMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool themeListener = ref.watch(themeListenerProvider);
    // String platform = Platform.operatingSystem;
    return Drawer(
      shape: const BeveledRectangleBorder(),
      clipBehavior: Clip.hardEdge,
      elevation: 1,
      child: Container(
        color: Theme.of(context).cardColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // if (platform == 'android' || platform == 'ios')
              //   const SizedBox(
              //     height: 50,
              //   ),
              HoverAnimatedContainer(
                hoverColor: themeListener == false
                    ? const Color.fromARGB(255, 37, 37, 37)
                    : Colors.grey.shade300,
                child: Container(
                  color: widget.url == '/'
                      ? themeListener == false
                          ? const Color.fromARGB(255, 37, 37, 37)
                          : Colors.grey.shade300
                      : null,
                  child: ListTile(
                    onTap: () async {
                      if (MediaQuery.of(context).size.width >= 1100) {
                        context.go(
                          '/',
                        );
                      } else {
                        context.go(
                          '/',
                        );
                        Navigator.pop(context);
                      }

                      // var prefs = await SharedPreferences.getInstance();
                      //prefs.setString('route-name', '/');
                    },
                    title: Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 12,
                      ),
                    ).tr(),
                    leading: Icon(Icons.dashboard,
                        color: Theme.of(context).iconTheme.color),
                  ),
                ),
              ),
              HoverAnimatedContainer(
                hoverColor: themeListener == false
                    ? const Color.fromARGB(255, 37, 37, 37)
                    : Colors.grey.shade300,
                child: Container(
                  color: widget.url == '/profile'
                      ? themeListener == false
                          ? const Color.fromARGB(255, 37, 37, 37)
                          : Colors.grey.shade300
                      : null,
                  child: ListTile(
                      onTap: () async {
                        if (MediaQuery.of(context).size.width >= 1100) {
                          context.go(
                            '/profile',
                          );
                        } else {
                          context.go(
                            '/profile',
                          );
                          Navigator.pop(context);
                        }

                        // var prefs = await SharedPreferences.getInstance();
                        //prefs.setString('route-name', 'profile');
                      },
                      title: Text(
                        'Profile',
                        style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 12,
                        ),
                      ).tr(),
                      leading: Icon(
                        Icons.people,
                        color: Theme.of(context).iconTheme.color,
                      )),
                ),
              ),

              BusinessDrawer(
                url: widget.url,
                themeListener: themeListener,
              ),
              BulkDrawer(
                url: widget.url,
                themeListener: themeListener,
              ),
              // HoverAnimatedContainer(
              //   hoverColor: themeListener == false
              //       ? const Color.fromARGB(255, 37, 37, 37)
              //       : Colors.grey.shade300,
              //   child: Container(
              //     color: widget.url == '/settings'
              //         ? themeListener == false
              //             ? const Color.fromARGB(255, 37, 37, 37)
              //             : Colors.grey.shade300
              //         : null,
              //     child: ListTile(
              //         onTap: () async {
              //           if (MediaQuery.of(context).size.width >= 1100) {
              //             context.go(
              //               '/settings',
              //             );
              //           } else {
              //             context.go(
              //               '/settings',
              //             );
              //             Navigator.pop(context);
              //           }

              //           // var prefs = await SharedPreferences.getInstance();
              //           //prefs.setString('route-name', 'app-settings');
              //         },
              //         title: Text(
              //           'App Settings',
              //           style: TextStyle(
              //             color: Theme.of(context).iconTheme.color,
              //             fontSize: 12,
              //           ),
              //         ).tr(),
              //         leading: Icon(Icons.settings,
              //             color: Theme.of(context).iconTheme.color)),
              //   ),
              // ),

              // HoverAnimatedContainer(
              //   hoverColor: themeListener == false
              //       ? const Color.fromARGB(255, 37, 37, 37)
              //       : Colors.grey.shade300,
              //   child: Container(
              //     color: widget.url == '/pickup-address'
              //         ? themeListener == false
              //             ? const Color.fromARGB(255, 37, 37, 37)
              //             : Colors.grey.shade300
              //         : null,
              //     child: ListTile(
              //         onTap: () async {
              //           if (MediaQuery.of(context).size.width >= 1100) {
              //             context.go(
              //               '/pickup-address',
              //             );
              //           } else {
              //             context.go(
              //               '/pickup-address',
              //             );
              //             Navigator.pop(context);
              //           }

              //           // var prefs = await SharedPreferences.getInstance();
              //           //prefs.setString('route-name', 'app-settings');
              //         },
              //         title: Text(
              //           'Pickup Settings',
              //           style: TextStyle(
              //             color: Theme.of(context).iconTheme.color,
              //             fontSize: 12,
              //           ),
              //         ).tr(),
              //         leading: Icon(Icons.delivery_dining,
              //             color: Theme.of(context).iconTheme.color)),
              //   ),
              // ),
              HoverAnimatedContainer(
                hoverColor: themeListener == false
                    ? const Color.fromARGB(255, 37, 37, 37)
                    : Colors.grey.shade300,
                child: Container(
                  color: widget.url == '/coupon'
                      ? themeListener == false
                          ? const Color.fromARGB(255, 37, 37, 37)
                          : Colors.grey.shade300
                      : null,
                  child: ListTile(
                      onTap: () async {
                        if (MediaQuery.of(context).size.width >= 1100) {
                          context.go(
                            '/coupon',
                          );
                        } else {
                          context.go(
                            '/coupon',
                          );
                          Navigator.pop(context);
                        }

                        // var prefs = await SharedPreferences.getInstance();
                        //prefs.setString('route-name', 'app-settings');
                      },
                      title: Text(
                        'Coupon Settings',
                        style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 12,
                        ),
                      ).tr(),
                      leading: Icon(Icons.card_giftcard,
                          color: Theme.of(context).iconTheme.color)),
                ),
              ),
              // HoverAnimatedContainer(
              //   hoverColor: Colors.grey.shade300,
              //   child: Container(
              //     color:  widget.url == '/bulk-emails' ? Colors.grey.shade300 : null,
              //     child: ListTile(
              //         onTap: () async {
              //           context.go(
              //             '/bulk-emails',
              //           );
              //           setState(() {
              //             categoryExpansionTile = true;
              //           });
              //         },
              //         title: Text(
              //           'Bulk Emails',
              //           style: TextStyle(
              //             color: Theme.of(context).iconTheme.color,
              //             fontSize: 12,
              //           ),
              //         ).tr(),
              //         leading: Icon(Icons.category,
              //             color: Theme.of(context).iconTheme.color)),
              //   ),
              // ),
              ExpansionTile(
                initiallyExpanded: widget.url == '/users-report' ||
                        widget.url == '/orders-report'
                    ? true
                    : false,
                title: Text(
                  'Reports',
                  style: TextStyle(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ).tr(),
                leading:
                    Icon(Icons.list, color: Theme.of(context).iconTheme.color),
                children: <Widget>[
                  HoverAnimatedContainer(
                    hoverColor: themeListener == false
                        ? const Color.fromARGB(255, 37, 37, 37)
                        : Colors.grey.shade300,
                    child: Container(
                      color: widget.url == '/users-report'
                          ? themeListener == false
                              ? const Color.fromARGB(255, 37, 37, 37)
                              : Colors.grey.shade300
                          : null,
                      child: ListTile(
                          onTap: () async {
                            context.go(
                              '/users-report',
                            );
                          },
                          title: Text(
                            'Users Report',
                            style: TextStyle(
                              color: Theme.of(context).iconTheme.color,
                              fontSize: 12,
                            ),
                          ).tr(),
                          leading: Icon(Icons.list,
                              color: Theme.of(context).iconTheme.color)),
                    ),
                  ),
                  HoverAnimatedContainer(
                    hoverColor: themeListener == false
                        ? const Color.fromARGB(255, 37, 37, 37)
                        : Colors.grey.shade300,
                    child: Container(
                      color: widget.url == '/orders-report'
                          ? themeListener == false
                              ? const Color.fromARGB(255, 37, 37, 37)
                              : Colors.grey.shade300
                          : null,
                      child: ListTile(
                          onTap: () async {
                            context.go(
                              '/orders-report',
                            );
                          },
                          title: Text(
                            'Orders Report',
                            style: TextStyle(
                              color: Theme.of(context).iconTheme.color,
                              fontSize: 12,
                            ),
                          ).tr(),
                          leading: Icon(Icons.list,
                              color: Theme.of(context).iconTheme.color)),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                // collapsedIconColor: Colors.white,
                // iconColor: Colors.white,
                // textColor: Colors.white,
                initiallyExpanded: widget.url == '/withdrawal-requests' ||
                        widget.url == '/completed-transactions'
                    ? true
                    : false,
                title: Text(
                  'Withdrawal Requests',
                  style: TextStyle(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ).tr(),
                leading: Icon(Icons.monetization_on_rounded,
                    color: Theme.of(context).iconTheme.color),
                children: <Widget>[
                  HoverAnimatedContainer(
                    hoverColor: themeListener == false
                        ? const Color.fromARGB(255, 37, 37, 37)
                        : Colors.grey.shade300,
                    child: Container(
                      color: widget.url == '/withdrawal-requests'
                          ? themeListener == false
                              ? const Color.fromARGB(255, 37, 37, 37)
                              : Colors.grey.shade300
                          : null,
                      child: ListTile(
                          onTap: () async {
                            context.go(
                              '/withdrawal-requests',
                            );
                            if (MediaQuery.of(context).size.width <= 1100) {
                              Navigator.pop(context);
                            }
                          },
                          title: Text(
                            'Withdrawal Requests',
                            style: TextStyle(
                              color: Theme.of(context).iconTheme.color,
                              fontSize: 12,
                            ),
                          ).tr(),
                          leading: Icon(Icons.monetization_on,
                              color: Theme.of(context).iconTheme.color)),
                    ),
                  ),
                  HoverAnimatedContainer(
                    hoverColor: themeListener == false
                        ? const Color.fromARGB(255, 37, 37, 37)
                        : Colors.grey.shade300,
                    child: Container(
                      color: widget.url == '/completed-transactions'
                          ? themeListener == false
                              ? const Color.fromARGB(255, 37, 37, 37)
                              : Colors.grey.shade300
                          : null,
                      child: ListTile(
                          onTap: () async {
                            context.go(
                              '/completed-transactions',
                            );
                            if (MediaQuery.of(context).size.width <= 1100) {
                              Navigator.pop(context);
                            }
                          },
                          title: Text(
                            'Completed Transactions',
                            style: TextStyle(
                              color: Theme.of(context).iconTheme.color,
                              fontSize: 12,
                            ),
                          ).tr(),
                          leading: Icon(Icons.monetization_on,
                              color: Theme.of(context).iconTheme.color)),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                initiallyExpanded:
                    widget.url == '/parcel-categories' ? true : false,
                leading: Icon(Icons.category,
                    color: Theme.of(context).iconTheme.color),
                title: Text('Categories Management',
                        style: TextStyle(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 12,
                            fontWeight: FontWeight.bold))
                    .tr(),
                children: [
                  HoverAnimatedContainer(
                    hoverColor: themeListener == false
                        ? const Color.fromARGB(255, 37, 37, 37)
                        : Colors.grey.shade300,
                    child: Container(
                      color: widget.url == '/parcel-categories'
                          ? themeListener == false
                              ? const Color.fromARGB(255, 37, 37, 37)
                              : Colors.grey.shade300
                          : null,
                      child: ListTile(
                          onTap: () async {
                            if (MediaQuery.of(context).size.width >= 1100) {
                              context.go(
                                '/parcel-categories',
                              );
                            } else {
                              context.go(
                                '/parcel-categories',
                              );
                              Navigator.pop(context);
                            }

                            // var prefs = await SharedPreferences.getInstance();
                            //prefs.setString('route-name', 'categories');
                          },
                          title: Text(
                            'Parcel Categories',
                            style: TextStyle(
                              color: Theme.of(context).iconTheme.color,
                              fontSize: 12,
                            ),
                          ).tr(),
                          leading: Icon(Icons.delivery_dining,
                              color: Theme.of(context).iconTheme.color)),
                    ),
                  ),
                ],
              ),
              HoverAnimatedContainer(
                hoverColor: themeListener == false
                    ? const Color.fromARGB(255, 37, 37, 37)
                    : Colors.grey.shade300,
                child: Container(
                  color: widget.url == '/orders'
                      ? themeListener == false
                          ? const Color.fromARGB(255, 37, 37, 37)
                          : Colors.grey.shade300
                      : null,
                  child: ListTile(
                    onTap: () async {
                      if (MediaQuery.of(context).size.width >= 1100) {
                        context.go(
                          '/orders',
                        );
                      } else {
                        context.go(
                          '/orders',
                        );
                        Navigator.pop(context);
                      }
                      // var prefs = await SharedPreferences.getInstance();
                      //prefs.setString('route-name', 'orders');
                    },
                    title: Text(
                      'Orders',
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).iconTheme.color),
                    ).tr(),
                    leading: Icon(Icons.list,
                        color: Theme.of(context).iconTheme.color),
                  ),
                ),
              ),

              HoverAnimatedContainer(
                hoverColor: themeListener == false
                    ? const Color.fromARGB(255, 37, 37, 37)
                    : Colors.grey.shade300,
                child: Container(
                  color: widget.url == '/users'
                      ? themeListener == false
                          ? const Color.fromARGB(255, 37, 37, 37)
                          : Colors.grey.shade300
                      : null,
                  child: ListTile(
                      onTap: () async {
                        if (MediaQuery.of(context).size.width >= 1100) {
                          context.go(
                            '/users',
                          );
                        } else {
                          context.go(
                            '/users',
                          );
                          Navigator.pop(context);
                        }

                        // var prefs = await SharedPreferences.getInstance();
                        //prefs.setString('route-name', 'users');
                      },
                      title: Text(
                        'Users',
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).iconTheme.color),
                      ).tr(),
                      leading: Icon(Icons.person,
                          color: Theme.of(context).iconTheme.color)),
                ),
              ),
              HoverAnimatedContainer(
                hoverColor: themeListener == false
                    ? const Color.fromARGB(255, 37, 37, 37)
                    : Colors.grey.shade300,
                child: Container(
                  color: widget.url == '/riders'
                      ? themeListener == false
                          ? const Color.fromARGB(255, 37, 37, 37)
                          : Colors.grey.shade300
                      : null,
                  child: ListTile(
                      onTap: () async {
                        if (MediaQuery.of(context).size.width >= 1100) {
                          context.go(
                            '/riders',
                          );
                        } else {
                          context.go(
                            '/riders',
                          );
                          Navigator.pop(context);
                        }

                        // var prefs = await SharedPreferences.getInstance();
                        //prefs.setString('route-name', 'users');
                      },
                      title: Text(
                        'Riders',
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).iconTheme.color),
                      ).tr(),
                      leading: Icon(Icons.person,
                          color: Theme.of(context).iconTheme.color)),
                ),
              ),
              ExpansionTile(
                initiallyExpanded:
                    widget.url == '/feeds' || widget.url == '/banners'
                        ? true
                        : false,
                leading:
                    Icon(Icons.feed, color: Theme.of(context).iconTheme.color),
                title: Text(
                  'Feeds',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Theme.of(context).iconTheme.color),
                ).tr(),
                children: [
                  HoverAnimatedContainer(
                    hoverColor: themeListener == false
                        ? const Color.fromARGB(255, 37, 37, 37)
                        : Colors.grey.shade300,
                    child: Container(
                      color: widget.url == '/feeds'
                          ? themeListener == false
                              ? const Color.fromARGB(255, 37, 37, 37)
                              : Colors.grey.shade300
                          : null,
                      child: ListTile(
                        onTap: () async {
                          if (MediaQuery.of(context).size.width >= 1100) {
                            context.go(
                              '/feeds',
                            );
                          } else {
                            context.go(
                              '/feeds',
                            );
                            Navigator.pop(context);
                          }
                          // var prefs = await SharedPreferences.getInstance();
                          //prefs.setString('route-name', 'feeds');
                        },
                        title: Text(
                          'Feeds',
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).iconTheme.color),
                        ).tr(),
                        leading: Icon(Icons.feed,
                            color: Theme.of(context).iconTheme.color),
                      ),
                    ),
                  ),
                ],
              ),
              HoverAnimatedContainer(
                hoverColor: themeListener == false
                    ? const Color.fromARGB(255, 37, 37, 37)
                    : Colors.grey.shade300,
                child: Container(
                  color: widget.url == '/notifications'
                      ? themeListener == false
                          ? const Color.fromARGB(255, 37, 37, 37)
                          : Colors.grey.shade300
                      : null,
                  child: ListTile(
                    onTap: () async {
                      if (MediaQuery.of(context).size.width >= 1100) {
                        context.go(
                          '/notifications',
                        );
                      } else {
                        context.go(
                          '/notifications',
                        );
                        Navigator.pop(context);
                      }
                      // var prefs = await SharedPreferences.getInstance();
                      //prefs.setString('route-name', 'notifications');
                    },
                    title: Text(
                      'Notifications',
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).iconTheme.color),
                    ).tr(),
                    leading: Icon(Icons.notifications,
                        color: Theme.of(context).iconTheme.color),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
