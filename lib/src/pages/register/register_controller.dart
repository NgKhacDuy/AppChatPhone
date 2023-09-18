import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

import '../../components/main/dialog/app_dialog_base_builder.dart';
import '../../components/main/overlay/app_loading_overlay_widget.dart';
import '../../config/app_theme.dart';
import '../../routes/app_page.dart';
import '../../services/auth/auth_service.dart';

part 'register_binding.dart';
part 'register_page.dart';

class RegisterController extends GetxController {
  RegisterController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString registerError = RxString('');

  void register() async {
    final authService = Get.find<AuthService>();
    if (emailController.text.isNotEmpty ||
        passwordController.text.isNotEmpty ||
        nameController.text.isNotEmpty) {
      try {
        AppLoadingOverlayWidget.show();
        UserCredential? userCredential =
            await authService.signUpWithNameEmailPassword(nameController.text,
                emailController.text, passwordController.text);
        AppLoadingOverlayWidget.dismiss();
        AppDefaultDialogWidget()
            .setAppDialogButtonType(AppDialogButtonType.standard)
            .setAppDialogType(AppDialogType.success)
            .setContent('Tạo tài khoản thành công')
            .setPositiveText('Chuyển về trang đăng nhập')
            .setOnPositive(() {
              Get.offAndToNamed(Routes.login);
            })
            .setIsHaveCloseIcon(true)
            .buildDialog(Get.context!)
            .show();
      } on FirebaseAuthException catch (e) {
        AppLoadingOverlayWidget.dismiss();
        if (e.code == 'email-already-in-use') {
          registerError.value = 'Tài khoản đã tồn tại';
        }
        Logs.e(e.code);
      }
    }
  }

  Widget showError() {
    if (registerError.value == '') {
      return const SizedBox();
    }
    return Text(
      registerError.value,
      style: const TextStyle(color: Colors.red),
    );
  }
}
