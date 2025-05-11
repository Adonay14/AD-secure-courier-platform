import 'package:admin/constance.dart';
import 'package:admin/providers/profile_provider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class ProfileData extends ConsumerWidget {
  const ProfileData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(profileDataNotifierProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(20),
          Padding(
            padding: MediaQuery.of(context).size.width >= 1100
                ? const EdgeInsets.only(left: 20, right: 20, bottom: 20)
                : const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Text(
                  'Admin Profile Settings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ).tr(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          profileData.image == null
              ? CircleAvatar(
                  radius:
                      MediaQuery.of(context).size.width >= 1100 ? 100.0 : 70,
                  backgroundImage: NetworkImage(profileData.adminImage),
                  backgroundColor: Colors.transparent,
                )
              : CircleAvatar(
                  radius:
                      MediaQuery.of(context).size.width >= 1100 ? 100.0 : 70,
                  backgroundImage: MemoryImage(profileData.image!),
                  backgroundColor: Colors.transparent,
                ),
          // IconButton(
          //   onPressed: () {
          //     ref.read(profileDataNotifierProvider.notifier).getImage();
          //   },
          //   icon: const Icon(Icons.add_a_photo),
          //   iconSize: 50,
          //   color: buttonColor,
          // ),
          SizedBox(
            child: Padding(
              padding: MediaQuery.of(context).size.width >= 1100
                  ? const EdgeInsets.only(left: 150, right: 150, bottom: 20)
                  : const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Text(
                    'Admin Username',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ).tr(),
                ],
              ),
            ),
          ),
          Padding(
            padding: MediaQuery.of(context).size.width >= 1100
                ? const EdgeInsets.only(left: 150, right: 150, bottom: 20)
                : const EdgeInsets.all(12.0),
            child: TextFormField(
              onChanged: (value) {
                ref
                    .read(profileDataNotifierProvider.notifier)
                    .setAdminUsernameonChanged(value);
              },
              decoration: InputDecoration(
                hintText: profileData.adminUsername,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                child: Padding(
                  padding: MediaQuery.of(context).size.width >= 1100
                      ? const EdgeInsets.only(left: 150, right: 150, bottom: 20)
                      : const EdgeInsets.all(12.0),
                  child: const Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ).tr(),
                ),
              ),
            ],
          ),
          Padding(
            padding: MediaQuery.of(context).size.width >= 1100
                ? const EdgeInsets.only(left: 150, right: 150, bottom: 20)
                : const EdgeInsets.all(12.0),
            child: TextFormField(
              obscureText: true,
              onChanged: (value) {
                ref
                    .read(profileDataNotifierProvider.notifier)
                    .setOldPasswordonChanged(value);
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                child: Padding(
                  padding: MediaQuery.of(context).size.width >= 1100
                      ? const EdgeInsets.only(left: 150, right: 150, bottom: 20)
                      : const EdgeInsets.all(12.0),
                  child: const Text(
                    'New Password',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ).tr(),
                ),
              ),
            ],
          ),
          Padding(
            padding: MediaQuery.of(context).size.width >= 1100
                ? const EdgeInsets.only(left: 150, right: 150, bottom: 20)
                : const EdgeInsets.all(12.0),
            child: TextFormField(
              obscureText: true,
              onChanged: (value) {
                ref
                    .read(profileDataNotifierProvider.notifier)
                    .setNewPassword(value);
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: demo == true
                ? () {
                    Fluttertoast.showToast(
                        msg: "Sorry this is in demo mode",
                        backgroundColor: buttonColor,
                        textColor: Colors.white);
                  }
                : () {
                    if (profileData.oldPasswordonChanged ==
                        profileData.oldPassword) {
                      ref
                          .read(profileDataNotifierProvider.notifier)
                          .updateAdmin(context);
                    } else {
                      Flushbar(
                        flushbarPosition: FlushbarPosition.TOP,
                        title: "Notification",
                        message:
                            "Please make sure your old password is correct!!!",
                        duration: const Duration(seconds: 3),
                      ).show(context);
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
            ),
            child: const Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ).tr(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
