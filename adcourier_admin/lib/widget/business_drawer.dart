import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hovering/hovering.dart';

class BusinessDrawer extends StatefulWidget {
  final String url;
  final bool themeListener;
  const BusinessDrawer(
      {super.key, required this.url, required this.themeListener});

  @override
  State<BusinessDrawer> createState() => _BusinessDrawerState();
}

class _BusinessDrawerState extends State<BusinessDrawer> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: widget.url == '/business-settings' ||
              widget.url == '/socials-settings' ||
              widget.url == 'delivery-settings' ||
              widget.url == '/privacy-policy' ||
              widget.url == '/terms-and-conditions' ||
              widget.url == '/about-us' ||
              widget.url == '/faq' ||
              widget.url == '/payment-gateway' ||
              widget.url == '/sms-settings' ||
              widget.url == '/mail-settings'
          ? true
          : false,
      leading: Icon(Icons.settings_applications,
          color: Theme.of(context).iconTheme.color),
      title: Text(
        'App Management',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Theme.of(context).iconTheme.color),
      ).tr(),
      children: [
////////////////////////////////////////////////// 1//////////////////////////////////////////////////
        ExpansionTile(
          initiallyExpanded: widget.url == '/business-settings' ||
                  widget.url == '/socials-settings' ||
                  widget.url == '/delivery-settings'
              ? true
              : false,
          leading:
              Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
          title: Text(
            'General Settings',
            style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Theme.of(context).iconTheme.color),
          ).tr(),
          children: [
            HoverAnimatedContainer(
              hoverColor: widget.themeListener == false
                  ? const Color.fromARGB(255, 37, 37, 37)
                  : Colors.grey.shade300,
              child: Container(
                color: widget.url == '/business-settings'
                    ? widget.themeListener == false
                        ? const Color.fromARGB(255, 37, 37, 37)
                        : Colors.grey.shade300
                    : null,
                child: ListTile(
                    onTap: () async {
                      if (MediaQuery.of(context).size.width >= 1100) {
                        context.go(
                          '/business-settings',
                        );
                      } else {
                        context.go(
                          '/business-settings',
                        );
                        Navigator.pop(context);
                      }

                      // var prefs = await SharedPreferences.getInstance();
                      //prefs.setString('route-name', 'app-settings');
                    },
                    title: Text(
                      'Business Settings',
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 12,
                      ),
                    ).tr(),
                    leading: Icon(Icons.business,
                        color: Theme.of(context).iconTheme.color)),
              ),
            ),
            HoverAnimatedContainer(
              hoverColor: widget.themeListener == false
                  ? const Color.fromARGB(255, 37, 37, 37)
                  : Colors.grey.shade300,
              child: Container(
                color: widget.url == '/socials-settings'
                    ? widget.themeListener == false
                        ? const Color.fromARGB(255, 37, 37, 37)
                        : Colors.grey.shade300
                    : null,
                child: ListTile(
                    onTap: () async {
                      if (MediaQuery.of(context).size.width >= 1100) {
                        context.go(
                          '/socials-settings',
                        );
                      } else {
                        context.go(
                          '/socials-settings',
                        );
                        Navigator.pop(context);
                      }

                      // var prefs = await SharedPreferences.getInstance();
                      //prefs.setString('route-name', 'app-settings');
                    },
                    title: Text(
                      'Socials Settings',
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 12,
                      ),
                    ).tr(),
                    leading: Icon(Icons.public,
                        color: Theme.of(context).iconTheme.color)),
              ),
            ),
          ],
        ),
/////////////////////////////////////////////////////// 2 ////////////////////////////////////////

        ExpansionTile(
          initiallyExpanded: widget.url == '/privacy-policy' ||
                  widget.url == '/terms-and-conditions' ||
                  widget.url == '/about-us' ||
                  widget.url == '/faq'
              ? true
              : false,
          leading:
              Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
          title: Text(
            'Legal Settings',
            style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Theme.of(context).iconTheme.color),
          ).tr(),
          children: [
            HoverAnimatedContainer(
              hoverColor: widget.themeListener == false
                  ? const Color.fromARGB(255, 37, 37, 37)
                  : Colors.grey.shade300,
              child: Container(
                color: widget.url == '/privacy-policy'
                    ? widget.themeListener == false
                        ? const Color.fromARGB(255, 37, 37, 37)
                        : Colors.grey.shade300
                    : null,
                child: ListTile(
                    onTap: () async {
                      if (MediaQuery.of(context).size.width >= 1100) {
                        context.go(
                          '/privacy-policy',
                        );
                      } else {
                        context.go(
                          '/privacy-policy',
                        );
                        Navigator.pop(context);
                      }

                      // var prefs = await SharedPreferences.getInstance();
                      //prefs.setString('route-name', 'app-settings');
                    },
                    title: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 12,
                      ),
                    ).tr(),
                    leading: Icon(Icons.privacy_tip,
                        color: Theme.of(context).iconTheme.color)),
              ),
            ),
            HoverAnimatedContainer(
              hoverColor: widget.themeListener == false
                  ? const Color.fromARGB(255, 37, 37, 37)
                  : Colors.grey.shade300,
              child: Container(
                color: widget.url == '/terms-and-conditions'
                    ? widget.themeListener == false
                        ? const Color.fromARGB(255, 37, 37, 37)
                        : Colors.grey.shade300
                    : null,
                child: ListTile(
                    onTap: () async {
                      if (MediaQuery.of(context).size.width >= 1100) {
                        context.go(
                          '/terms-and-conditions',
                        );
                      } else {
                        context.go(
                          '/terms-and-conditions',
                        );
                        Navigator.pop(context);
                      }

                      // var prefs = await SharedPreferences.getInstance();
                      //prefs.setString('route-name', 'app-settings');
                    },
                    title: Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 12,
                      ),
                    ).tr(),
                    leading: Icon(Icons.security,
                        color: Theme.of(context).iconTheme.color)),
              ),
            ),
            HoverAnimatedContainer(
              hoverColor: widget.themeListener == false
                  ? const Color.fromARGB(255, 37, 37, 37)
                  : Colors.grey.shade300,
              child: Container(
                color: widget.url == '/about-us'
                    ? widget.themeListener == false
                        ? const Color.fromARGB(255, 37, 37, 37)
                        : Colors.grey.shade300
                    : null,
                child: ListTile(
                    onTap: () async {
                      if (MediaQuery.of(context).size.width >= 1100) {
                        context.go(
                          '/about-us',
                        );
                      } else {
                        context.go(
                          '/about-us',
                        );
                        Navigator.pop(context);
                      }

                      // var prefs = await SharedPreferences.getInstance();
                      //prefs.setString('route-name', 'app-settings');
                    },
                    title: Text(
                      'About Us',
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 12,
                      ),
                    ).tr(),
                    leading: Icon(Icons.group,
                        color: Theme.of(context).iconTheme.color)),
              ),
            ),
            HoverAnimatedContainer(
              hoverColor: widget.themeListener == false
                  ? const Color.fromARGB(255, 37, 37, 37)
                  : Colors.grey.shade300,
              child: Container(
                color: widget.url == '/faq'
                    ? widget.themeListener == false
                        ? const Color.fromARGB(255, 37, 37, 37)
                        : Colors.grey.shade300
                    : null,
                child: ListTile(
                    onTap: () async {
                      if (MediaQuery.of(context).size.width >= 1100) {
                        context.go(
                          '/faq',
                        );
                      } else {
                        context.go(
                          '/faq',
                        );
                        Navigator.pop(context);
                      }

                      // var prefs = await SharedPreferences.getInstance();
                      //prefs.setString('route-name', 'app-settings');
                    },
                    title: Text(
                      'FAQ',
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 12,
                      ),
                    ).tr(),
                    leading: Icon(Icons.quiz,
                        color: Theme.of(context).iconTheme.color)),
              ),
            ),
          ],
        ),
///////////////////////////////////////// 3 /////////////////////////////////////////////////
        ExpansionTile(
          initiallyExpanded: widget.url == '/payment-gateway' ||
                  widget.url == '/sms-settings' ||
                  widget.url == '/mail-settings'
              ? true
              : false,
          leading:
              Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
          title: Text(
            '3rd Party Settings',
            style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Theme.of(context).iconTheme.color),
          ).tr(),
          children: [
            HoverAnimatedContainer(
              hoverColor: widget.themeListener == false
                  ? const Color.fromARGB(255, 37, 37, 37)
                  : Colors.grey.shade300,
              child: Container(
                color: widget.url == '/payment-gateway'
                    ? widget.themeListener == false
                        ? const Color.fromARGB(255, 37, 37, 37)
                        : Colors.grey.shade300
                    : null,
                child: ListTile(
                    onTap: () async {
                      if (MediaQuery.of(context).size.width >= 1100) {
                        context.go(
                          '/payment-gateway',
                        );
                      } else {
                        context.go(
                          '/payment-gateway',
                        );
                        Navigator.pop(context);
                      }

                      // var prefs = await SharedPreferences.getInstance();
                      //prefs.setString('route-name', 'app-settings');
                    },
                    title: Text(
                      'Payment Gateway',
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
              hoverColor: widget.themeListener == false
                  ? const Color.fromARGB(255, 37, 37, 37)
                  : Colors.grey.shade300,
              child: Container(
                color: widget.url == '/sms-settings'
                    ? widget.themeListener == false
                        ? const Color.fromARGB(255, 37, 37, 37)
                        : Colors.grey.shade300
                    : null,
                child: ListTile(
                    onTap: () async {
                      if (MediaQuery.of(context).size.width >= 1100) {
                        context.go(
                          '/sms-settings',
                        );
                      } else {
                        context.go(
                          '/sms-settings',
                        );
                        Navigator.pop(context);
                      }

                      // var prefs = await SharedPreferences.getInstance();
                      //prefs.setString('route-name', 'app-settings');
                    },
                    title: Text(
                      'SMS / Whatsapp settings',
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 12,
                      ),
                    ).tr(),
                    leading: Icon(Icons.sms,
                        color: Theme.of(context).iconTheme.color)),
              ),
            ),
            HoverAnimatedContainer(
              hoverColor: widget.themeListener == false
                  ? const Color.fromARGB(255, 37, 37, 37)
                  : Colors.grey.shade300,
              child: Container(
                color: widget.url == '/mail-settings'
                    ? widget.themeListener == false
                        ? const Color.fromARGB(255, 37, 37, 37)
                        : Colors.grey.shade300
                    : null,
                child: ListTile(
                    onTap: () async {
                      if (MediaQuery.of(context).size.width >= 1100) {
                        context.go(
                          '/mail-settings',
                        );
                      } else {
                        context.go(
                          '/mail-settings',
                        );
                        Navigator.pop(context);
                      }

                      // var prefs = await SharedPreferences.getInstance();
                      //prefs.setString('route-name', 'app-settings');
                    },
                    title: Text(
                      'Mail Settings',
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 12,
                      ),
                    ).tr(),
                    leading: Icon(Icons.email,
                        color: Theme.of(context).iconTheme.color)),
              ),
            ),
          ],
        )
      ],
    );
  }
}
