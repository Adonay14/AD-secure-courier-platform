// ignore_for_file: avoid_build_context_in_providers
import 'dart:typed_data';
import 'package:admin/models/profile_model.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_provider.g.dart';

@riverpod
class ProfileDataNotifier extends _$ProfileDataNotifier {
  @override
  ProfileModel build() {
    getFirebaseDetails();
    return ProfileModel();
  }

  Future<void> updateAdmin(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('Admin').doc('Admin').update({
        'ProfilePic': whenProfilePics(),
        'password': state.newPassword,
        'username': whenUsername(),
      });

      state = state.copyWith(
        adminUsernameonChanged: '',
        oldPasswordonChanged: '',
        newPassword: '',
      );
      if (context.mounted) {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          title: "Notification",
          message: "Admin has been updated!!!",
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    } catch (e) {
      if (context.mounted) {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          title: "Error",
          message: "Failed to update admin.",
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    }
  }

  String whenProfilePics() {
    return state.firestoreImage.isEmpty
        ? state.adminImage
        : state.firestoreImage;
  }

  String whenUsername() {
    return state.adminUsernameonChanged.isEmpty
        ? state.adminUsername
        : state.adminUsernameonChanged;
  }

  Future<void> getFirebaseDetails() async {
    try {
      final value = await FirebaseFirestore.instance
          .collection('Admin')
          .doc('Admin')
          .get();

      state = state.copyWith(
        adminImage: value['ProfilePic'] ?? '',
        oldPassword: value['password'] ?? '',
        adminUsername: value['username'] ?? '',
      );
    } catch (e) {
      // Handle errors if necessary
    }
  }

  Future<void> getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    );

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      if (fileBytes != null) {
        TaskSnapshot upload = await FirebaseStorage.instance
            .ref('uploads/${DateTime.now()}')
            .putData(fileBytes);
        final url = await upload.ref.getDownloadURL();
        state = state.copyWith(
          image: fileBytes,
          firestoreImage: url,
        );
      }
    }
  }

  void setOldPasswordonChanged(String value) {
    state = state.copyWith(
      oldPasswordonChanged: value,
    );
  }

  void setAdminUsernameonChanged(String value) {
    state = state.copyWith(
      adminUsernameonChanged: value,
    );
  }

  void setNewPassword(String value) {
    state = state.copyWith(
      newPassword: value,
    );
  }
}
