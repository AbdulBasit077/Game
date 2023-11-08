class UserModel {
// String firstName;
  String name;
  String email;
  String phoneNumber;
  String password;
  String uid;
  String timestamp;
  String country;

  UserModel({
// required this.firstName,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.uid,
    required this.timestamp,
    required this.country,
  });
}
