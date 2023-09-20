import 'package:app_chat/src/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:utilities/utilities.dart';

class GeneralService extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> findUserByName(String name) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('name', isEqualTo: name)
          .get();
      List<UserModel> users = querySnapshot.docs
          .map((documentSnapshot) => UserModel.fromSnapshot(documentSnapshot))
          .toList();
      Logs.e(users);
      Logs.e(users.runtimeType);
    } on FirebaseException catch (e) {
      Logs.e(e);
    }
  }
}
