import 'package:admin/constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/notifications.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    yourStream = FirebaseFirestore.instance
        .collection('Notifications')
        .get()
        .then((event) => event.docs
            .map((e) => NotificationsModel.fromMap(e.data(), e.id))
            .toList());
    super.initState();
  }

  Future<List<NotificationsModel>>? yourStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.notifications,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Notifications',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ).tr(),
                            const SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<NotificationsModel>>(
                future: yourStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.notifications,
                                  color: Colors.grey,
                                  size: MediaQuery.of(context).size.height / 3,
                                ),
                                const SizedBox(height: 40),
                                const Text("Notification is Empty",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))
                                    .tr()
                              ],
                            ),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, int index) {
                              NotificationsModel notificationsModel =
                                  snapshot.data![index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 100,
                                  child: Card(
                                    child: ListTile(
                                      trailing: InkWell(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection('Notifications')
                                                .doc(notificationsModel.uid)
                                                .delete()
                                                .then((value) {});
                                          },
                                          child: const Icon(Icons.delete)),
                                      title: notificationsModel
                                                  // ignore: unnecessary_null_comparison
                                                  .heading ==
                                              null
                                          ? const Text('')
                                          : Text(notificationsModel.heading,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: buttonColor)),
                                      subtitle: notificationsModel
                                                  // ignore: unnecessary_null_comparison
                                                  .content ==
                                              null
                                          ? const Text('')
                                          : SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.3,
                                              child: Text(
                                                  notificationsModel.content,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                      leading: const Icon(
                                        Icons.notifications,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                  } else {
                    return Container();
                  }
                })
          ],
        ),
      ),
    );
  }
}
