import 'package:app_chat/src/components/main/page/app_main_page_base_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:utilities/utilities.dart';

import '../../routes/app_page.dart';
import '../../services/auth/auth_service.dart';

part 'home_page.dart';
part 'home_binding.dart';

class HomeController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final authService = Get.find<AuthService>();

  void logout() async {
    await authService.signOutAll();
  }
}
