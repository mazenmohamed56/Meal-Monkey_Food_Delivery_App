class UserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String address;
  late String profileImagepath;

  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.address,
    required this.profileImagepath,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    address = json['address'];
    profileImagepath = json['profileImagepath'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'address': address,
      'profileImagepath': profileImagepath,
    };
  }
}
