import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../routes/app_page.dart';

class AppController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void checkLogin() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        Get.toNamed(Routes.home);
      }
    });
  }
}
