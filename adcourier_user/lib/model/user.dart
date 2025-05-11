class UserModel {
  final String phonenumber;
  final String uid;
  final String email;
  final String displayName;
  final String token;
  final String referralCode;
  final String photoUrl;
  final String? address;
  final String? module;
  final num? totalNumberOfUserRating;
  final num? totalRating;
  final DateTime? timeCreated;
  final bool? isOpened;

  UserModel({
    this.module,
    this.timeCreated,
    this.isOpened,
    required this.email,
    this.totalRating,
    this.totalNumberOfUserRating,
    required this.displayName,
    this.address,
    required this.photoUrl,
    required this.uid,
    required this.token,
    required this.phonenumber,
    required this.referralCode,
  });

  UserModel.fromMap(Map<String, dynamic> data, this.uid)
      : displayName = data['fullname'],
        isOpened = data['isOpened'],
        module = data['module'],
        timeCreated = data['timeCreated'].toDate(),
        totalRating = data['totalRating'],
        totalNumberOfUserRating = data['totalNumberOfUserRating'],
        email = data['email'],
        address = data['address'],
        photoUrl = data['photoUrl'],
        referralCode = data['personalReferralCode'],
        token = data['tokenID'],
        phonenumber = data['phone'];
}
