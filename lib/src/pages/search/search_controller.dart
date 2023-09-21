import 'package:app_chat/src/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app_chat/src/config/app_theme.dart';
import 'package:app_chat/src/services/general/general_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:utilities/utilities.dart';

import '../../services/auth/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'search_binding.dart';
part 'search_page.dart';

class SearchUserController extends GetxController {
  final generalService = Get.find<GeneralService>();
  final authService = Get.find<AuthService>();

  RxList listUser = RxList([]);
  TextEditingController _textEditingController = TextEditingController();

  void findUserByName(String name) async {
    AppLoadingOverlayWidget.show();
    listUser.value = await generalService.findUserByName(name);
    AppLoadingOverlayWidget.dismiss();
  }

  void logout() async {
    await authService.signOutAll();
  }
}
