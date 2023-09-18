import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<UserCredential?> userCredential = Rx<UserCredential?>(null);

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      userCredential.value = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _firestore.collection('users').doc(userCredential.value?.user!.uid).set(
          {'uid': userCredential.value?.user!.uid, 'email': email},
          SetOptions(merge: true));
      return userCredential.value;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<UserCredential?> signUpWithNameEmailPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email, 'name': name});
      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
