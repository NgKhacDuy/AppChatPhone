import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String name;
  final String email;
  final String uid;
  final String? imgPath;

  UserModel(
      {required this.name,
      required this.email,
      required this.uid,
      required this.imgPath});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        uid: json['uid'] ?? '',
        imgPath: json['img'] ?? '');
  }
}
