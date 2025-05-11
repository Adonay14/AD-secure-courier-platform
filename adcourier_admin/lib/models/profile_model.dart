import 'dart:typed_data';

class ProfileModel {
  final String firestoreImage;
  final Uint8List? image;
  final String newPassword;
  final String oldPassword;
  final String oldPasswordonChanged;
  final String adminUsernameonChanged;
  final String adminUsername;
  final String adminImage;

  ProfileModel({
    this.firestoreImage = '',
    this.image,
    this.newPassword = '',
    this.oldPassword = '',
    this.oldPasswordonChanged = '',
    this.adminUsernameonChanged = '',
    this.adminUsername = '',
    this.adminImage = '',
  });

  ProfileModel copyWith({
    String? firestoreImage,
    Uint8List? image,
    String? newPassword,
    String? oldPassword,
    String? oldPasswordonChanged,
    String? adminUsernameonChanged,
    String? adminUsername,
    String? adminImage,
  }) {
    return ProfileModel(
      firestoreImage: firestoreImage ?? this.firestoreImage,
      image: image ?? this.image,
      newPassword: newPassword ?? this.newPassword,
      oldPassword: oldPassword ?? this.oldPassword,
      oldPasswordonChanged: oldPasswordonChanged ?? this.oldPasswordonChanged,
      adminUsernameonChanged: adminUsernameonChanged ?? this.adminUsernameonChanged,
      adminUsername: adminUsername ?? this.adminUsername,
      adminImage: adminImage ?? this.adminImage,
    );
  }
}