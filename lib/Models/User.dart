



String userId = "";

class UserModel {
  String uid;
  String name;
  String email;
  String password;
  String phone;
  String bloodGroup;
  String location;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.bloodGroup,
    required this.location,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      password: '',
      phone: json['phone'],
      bloodGroup: json['bloodGroup'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'bloodGroup': bloodGroup,
      'location': location,
    };
  }





}
