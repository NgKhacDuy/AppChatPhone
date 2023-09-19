import 'package:app_chat/src/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app_chat/src/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app_chat/src/config/app_theme.dart';
import 'package:app_chat/src/routes/app_page.dart';
import 'package:app_chat/src/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resources/resources.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:utilities/utilities.dart';

part 'login_binding.dart';
part 'login_page.dart';

class LoginController extends GetxController {
  LoginController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString loginError = RxString('');

  void login() async {
    final authService = Get.find<AuthService>();
    if (emailController.text.isNotEmpty || passwordController.text.isNotEmpty) {
      if (isEmail(emailController.text)) {
        try {
          AppLoadingOverlayWidget.show();
          UserCredential? userCredential =
              await authService.signInWithEmailAndPassword(
                  emailController.text, passwordController.text);
          if (userCredential != null) {
            Get.offAndToNamed(Routes.home);
          } else {
            loginError.value =
                'Email hoặc mật khẩu không đúng, vui lòng nhập lại';
          }
          AppLoadingOverlayWidget.dismiss();
        } on FirebaseAuthException catch (e) {
          AppLoadingOverlayWidget.dismiss();
          if (e.code == 'user-not-found') {
            loginError.value =
                'Email hoặc mật khẩu không đúng, vui lòng nhập lại';
          } else {
            AppDefaultDialogWidget()
                .setAppDialogButtonType(AppDialogButtonType.standard)
                .setAppDialogType(AppDialogType.error)
                .setContent('Đã có lỗi xảy ra, vui lòng thử lại.')
                .setIsHaveCloseIcon(true)
                .buildDialog(Get.context!)
                .show();
            Logs.e(e);
          }
        }
      } else {
        loginError.value = 'Vui lòng nhập đúng định dạng email';
      }
    } else {
      loginError.value = 'Vui lòng nhập đủ email và mật khẩu';
      Logs.e(loginError.value);
    }
  }

  Widget showError() {
    if (loginError.value == '') {
      return const SizedBox();
    }
    return Text(
      loginError.value,
      style: const TextStyle(color: Colors.red),
    );
  }

  bool isEmail(String input) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(input);
  }

  void loginWithGoogle() async {
    final authService = Get.find<AuthService>();
    try {
      UserCredential? userCredential = await authService.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      Logs.e(e);
      Logs.e(e.code);
    }
  }
}
