import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hovering/hovering.dart';

class BulkDrawer extends StatefulWidget {
  final String url;
  final bool themeListener;
  const BulkDrawer({super.key, required this.url, required this.themeListener});

  @override
  State<BulkDrawer> createState() => _BulkDrawerState();
}

class _BulkDrawerState extends State<BulkDrawer> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: widget.url == '/push-notifications' ||
              widget.url == '/bulk-sms' ||
              widget.url == 'bulk-email' ||
              widget.url == '/bulk-whatsapp'
          ? true
          : false,
      leading: Icon(Icons.settings_applications,
          color: Theme.of(context).iconTheme.color),
      title: Text(
        'Bulk Management',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Theme.of(context).iconTheme.color),
      ).tr(),
      children: [
        HoverAnimatedContainer(
          hoverColor: widget.themeListener == false
              ? const Color.fromARGB(255, 37, 37, 37)
              : Colors.grey.shade300,
          child: Container(
            color: widget.url == '/push-notifications'
                ? widget.themeListener == false
                    ? const Color.fromARGB(255, 37, 37, 37)
                    : Colors.grey.shade300
                : null,
            child: ListTile(
                onTap: () async {
                  if (MediaQuery.of(context).size.width >= 1100) {
                    context.go(
                      '/push-notifications',
                    );
                  } else {
                    context.go(
                      '/push-notifications',
                    );
                    Navigator.pop(context);
                  }

                  // var prefs = await SharedPreferences.getInstance();
                  //prefs.setString('route-name', 'app-settings');
                },
                title: Text(
                  'Bulk Push Notifications',
                  style: TextStyle(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 12,
                  ),
                ).tr(),
                leading: Icon(Icons.notification_important,
                    color: Theme.of(context).iconTheme.color)),
          ),
        ),
        HoverAnimatedContainer(
          hoverColor: widget.themeListener == false
              ? const Color.fromARGB(255, 37, 37, 37)
              : Colors.grey.shade300,
          child: Container(
            color: widget.url == '/bulk-sms'
                ? widget.themeListener == false
                    ? const Color.fromARGB(255, 37, 37, 37)
                    : Colors.grey.shade300
                : null,
            child: ListTile(
                onTap: () async {
                  if (MediaQuery.of(context).size.width >= 1100) {
                    context.go(
                      '/bulk-sms',
                    );
                  } else {
                    context.go(
                      '/bulk-sms',
                    );
                    Navigator.pop(context);
                  }

                  // var prefs = await SharedPreferences.getInstance();
                  //prefs.setString('route-name', 'app-settings');
                },
                title: Text(
                  'Bulk Sms',
                  style: TextStyle(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 12,
                  ),
                ).tr(),
                leading:
                    Icon(Icons.sms, color: Theme.of(context).iconTheme.color)),
          ),
        ),
        HoverAnimatedContainer(
          hoverColor: widget.themeListener == false
              ? const Color.fromARGB(255, 37, 37, 37)
              : Colors.grey.shade300,
          child: Container(
            color: widget.url == '/bulk-email'
                ? widget.themeListener == false
                    ? const Color.fromARGB(255, 37, 37, 37)
                    : Colors.grey.shade300
                : null,
            child: ListTile(
                onTap: () async {
                  if (MediaQuery.of(context).size.width >= 1100) {
                    context.go(
                      '/bulk-email',
                    );
                  } else {
                    context.go(
                      '/bulk-email',
                    );
                    Navigator.pop(context);
                  }

                  // var prefs = await SharedPreferences.getInstance();
                  //prefs.setString('route-name', 'app-settings');
                },
                title: Text(
                  'Bulk Email',
                  style: TextStyle(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 12,
                  ),
                ).tr(),
                leading: Icon(Icons.email,
                    color: Theme.of(context).iconTheme.color)),
          ),
        ),
          HoverAnimatedContainer(
          hoverColor: widget.themeListener == false
              ? const Color.fromARGB(255, 37, 37, 37)
              : Colors.grey.shade300,
          child: Container(
            color: widget.url == '/bulk-whatsapp'
                ? widget.themeListener == false
                    ? const Color.fromARGB(255, 37, 37, 37)
                    : Colors.grey.shade300
                : null,
            child: ListTile(
                onTap: () async {
                  if (MediaQuery.of(context).size.width >= 1100) {
                    context.go(
                      '/bulk-whatsapp',
                    );
                  } else {
                    context.go(
                      '/bulk-whatsapp',
                    );
                    Navigator.pop(context);
                  }

                  // var prefs = await SharedPreferences.getInstance();
                  //prefs.setString('route-name', 'app-settings');
                },
                title: Text(
                  'Bulk whatsapp message',
                  style: TextStyle(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 12,
                  ),
                ).tr(),
                leading:
                    Icon(Icons.sms, color: Theme.of(context).iconTheme.color)),
          ),
        ),
      ],
    );
  }
}
