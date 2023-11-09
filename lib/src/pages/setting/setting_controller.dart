import 'dart:ui';

import 'package:app_chat/src/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app_chat/src/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app_chat/src/model/user_model.dart';
import 'package:app_chat/src/routes/app_page.dart';
import 'package:app_chat/src/services/general/general_service.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:resources/resources.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:utilities/utilities.dart';

import '../../config/app_theme.dart';
import 'components/user_card.dart';
part 'setting_binding.dart';
part 'setting_page.dart';

class SettingController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GeneralService generalService = Get.find<GeneralService>();
  RxString imgPath = RxString('');
  late Rx<UserModel> userModel;

  @override
  void onReady() async {
    userModel =
        Rx(UserModel(imgPath: imgPath.value, name: '', email: '', uid: ''));
    await initFetch();
  }

  Future<void> initFetch() async {
    userModel.value =
        await generalService.getUserById(_firebaseAuth.currentUser!.uid);
  }

  void goToEditAvatar() async {
    var temp = await generalService.getUserById(_firebaseAuth.currentUser!.uid);
    UserModel userModel = temp;
    Get.toNamed(Routes.editAvatar, arguments: userModel)?.then((value) {
      Logs.e(value);
      value != null ? imgPath.value = value : imgPath.value = '';
    });
  }
}
