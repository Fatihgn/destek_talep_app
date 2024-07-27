import 'package:destek_talep_app/services/models/post_model.dart';

class UserModel {
  final String email, name, password, phone, tcNo;
  final Posts posts;

  UserModel(
      {required this.email,
      required this.name,
      required this.password,
      required this.posts,
      required this.phone,
      required this.tcNo});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'],
        name: json['name'],
        password: json['password'],
        posts: json['posts'],
        phone: json['phone'],
        tcNo: json['tcNo']);
  }
}
