import 'dart:async';
import 'package:app_chat/src/components/main/appBar/app_bar_base_builder.dart';
import 'package:app_chat/src/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app_chat/src/components/main/page/app_main_page_base_builder.dart';
import 'package:app_chat/src/config/app_theme.dart';
import 'package:app_chat/src/pages/chat/components/chat_bubble.dart';
import 'package:app_chat/src/services/message/message_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

import '../../components/main/button/app_button_base_builder.dart';
import '../../components/main/dialog/app_dialog_base_builder.dart';
import '../../services/encrypt/encrypt_message.dart';

part 'chat_binding.dart';
part 'chat_page.dart';

class ChatController extends GetxController {
  var currentUserData = Get.arguments;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final messageService = Get.find<MessageService>();
  TextEditingController inputController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  RxBool isChooseEncrypt = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    scrollDown();
  }

  String getUIDCurrentUser() {
    final User? user = _firebaseAuth.currentUser;
    return user!.uid;
  }

  Stream<QuerySnapshot> getMessage() {
    return messageService.getMessage(
        currentUserData[0], _firebaseAuth.currentUser!.uid);
  }

  void changeEncryptIcon() {
    if (isChooseEncrypt.value == true) {
      isChooseEncrypt.value = false;
    } else {
      isChooseEncrypt.value = true;
    }
  }

  void sendMessage() async {
    if (inputController.text.isNotEmpty) {
      if (isChooseEncrypt.value == false) {
        await messageService.sendMessage(
            currentUserData[0], inputController.text);
      } else {
        final plainText = EncryptionDecryption.encryptAES(inputController.text);
        await messageService.sendMessage(currentUserData[0],
            plainText[0].base64, plainText[1], plainText[2]);
      }
      inputController.clear();
    }
  }

  String decryption(String text, String iv, String key) {
    try {
      return EncryptionDecryption.decryptAES(
          Encrypted.fromBase64(text), iv, key);
    } catch (e) {
      Logs.e(e);
      AppDefaultDialogWidget()
          .setContent(
              'Đã có lỗi xảy ra, không thể giải mã hoặc tin nhắn đã được giải mã')
          .setAppDialogButtonType(AppDialogButtonType.danger)
          .setAppDialogType(AppDialogType.error)
          .setIsHaveCloseIcon(true)
          .buildDialog(Get.context!)
          .show();
      return text;
    }
  }

  String convertTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    int hours = dateTime.hour;
    int day = dateTime.day;
    int month = dateTime.month;
    int minutes = dateTime.minute;
    return '$day/$month $hours:$minutes';
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(
          0.0,
        );
      } else {
        Timer(const Duration(microseconds: 1), () => scrollDown());
      }
    });
  }
}
