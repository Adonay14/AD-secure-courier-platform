import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:user_web/constant.dart';
import '../Providers/auth.dart';

class MobileMenuWidget extends StatefulWidget {
  final bool isLogged;
  final Function moveToOrder;
  final String module;
  const MobileMenuWidget(
      {super.key,
      required this.module,
      required this.isLogged,
      required this.moveToOrder});

  @override
  State<MobileMenuWidget> createState() => _MobileMenuWidgetState();
}

class _MobileMenuWidgetState extends State<MobileMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(children: [
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(
                logo,
                scale: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 30,
                    color: appColor,
                  )),
            )
          ],
        ),
        const Divider(color: Colors.grey),
        const Gap(20),
        ListTile(
          onTap: () {
            if (widget.isLogged == true) {
              context.go('/profile');
              context.pop();
            } else {
              context.go('/login');
            }
          },
          title: const Text('Profile').tr(),
          leading: const Icon(Icons.person),
          trailing: const Icon(Icons.chevron_right),
        ),
        ListTile(
          onTap: () {
            if (widget.isLogged == true) {
              context.go('/wallet');
              context.pop();
            } else {
              context.go('/login');
            }
          },
          title: const Text('Wallet').tr(),
          leading: const Icon(Icons.wallet),
          trailing: const Icon(Icons.chevron_right),
        ),
        // ListTile(
        //   onTap: () {
        //     if (widget.isLogged == true) {
        //       context.go('/orders');
        //       context.pop();
        //     } else {
        //       context.go('/login');
        //     }
        //   },
        //   title: const Text('Orders').tr(),
        //   leading: const Icon(Icons.list),
        //   trailing: const Icon(Icons.chevron_right),
        // ),
        // ListTile(
        //   onTap: () {
        //     // if (widget.isLogged == true) {
        //     context.go('/${widget.module}/favorites');
        //     context.pop();
        //     // } else {
        //     //   context.go('/login');
        //     // }
        //   },
        //   title: const Text('Favorites').tr(),
        //   leading: const Icon(Icons.favorite),
        //   trailing: const Icon(Icons.chevron_right),
        // ),
        ListTile(
          onTap: () {
            if (widget.isLogged == true) {
              context.go('/voucher');
              context.pop();
            } else {
              context.go('/login');
            }
          },
          title: const Text('Voucher').tr(),
          leading: const Icon(Icons.card_giftcard),
          trailing: const Icon(Icons.chevron_right),
        ),
        ListTile(
          onTap: () {
            if (widget.isLogged == true) {
              context.go('/inbox');
              context.pop();
            } else {
              context.go('/login');
            }
          },
          title: const Text('Inbox').tr(),
          leading: const Icon(Icons.notifications),
          trailing: const Icon(Icons.chevron_right),
        ),
        // ListTile(
        //   onTap: () {
        //     if (widget.isLogged == true) {
        //       context.go('/delivery-addresses');
        //       context.pop();
        //     } else {
        //       context.go('/login');
        //     }
        //   },
        //   title: const Text('Address Book').tr(),
        //   leading: const Icon(Icons.room),
        //   trailing: const Icon(Icons.chevron_right),
        // ),
        ListTile(
          onTap: () {
            if (widget.isLogged == true) {
              context.go('/track-order');
              context.pop();
            } else {
              context.go('/login');
            }
          },
          title: const Text('Track Order').tr(),
          leading: const Icon(Icons.room),
          trailing: const Icon(Icons.chevron_right),
        ),
       
       
        const Divider(
          color: Colors.grey,
          thickness: 2,
        ),
        const Gap(10),
        SwitchListTile(
          title: const Text('Theme'),
          value: AdaptiveTheme.of(context).mode.isDark,
          onChanged: (value) {
            if (value) {
              AdaptiveTheme.of(context).setDark();
            } else {
              AdaptiveTheme.of(context).setLight();
            }
          },
        ),
        widget.isLogged == true
            ? ListTile(
                onTap: () {
                  AuthService().signOut(context);
                  context.pop();
                },
                title: const Text('Logout').tr(),
                leading: const Icon(Icons.logout),
                // trailing: const Icon(Icons.chevron_right),
              )
            : ListTile(
                onTap: () {
                  context.go('/login');
                },
                title: const Text('Login').tr(),
                leading: const Icon(Icons.login),
                // trailing: const Icon(Icons.chevron_right),
              ),
      ]),
    );
  }
}
