import 'package:admin/Widget/push_notifications_datatable.dart';
import 'package:admin/constance.dart';
import 'package:flutter/material.dart';

import '../../Widget/add_push_notifications.dart';

class PushNotificationPage extends StatefulWidget {
  const PushNotificationPage({super.key});

  @override
  State<PushNotificationPage> createState() => _PushNotificationPageState();
}

class _PushNotificationPageState extends State<PushNotificationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  floatingActionButtonLocation:MediaQuery.of(context).size.width >= 1100? FloatingActionButtonLocation.endTop:FloatingActionButtonLocation.endDocked,
      floatingActionButton: MediaQuery.of(context).size.width >= 1100
          ? null
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                backgroundColor: buttonColor,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return const AddPushNotification();
                      });
                },
                child: const Icon(Icons.add),
              ),
            ),
      body: const SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: PushNotificationsData(),
            ),
          ],
        ),
      ),
    );
  }
}
