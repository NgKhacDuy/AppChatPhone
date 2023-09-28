import 'package:app_chat/src/components/main/appBar/app_bar_base_builder.dart';
import 'package:app_chat/src/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app_chat/src/components/main/page/app_main_page_base_builder.dart';
import 'package:app_chat/src/config/app_theme.dart';
import 'package:app_chat/src/pages/chat/components/chat_bubble.dart';
import 'package:app_chat/src/services/message/message_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:utilities/utilities.dart';

part 'chat_binding.dart';
part 'chat_page.dart';

class ChatController extends GetxController {
  var currentUserData = Get.arguments;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final messageService = Get.find<MessageService>();
  TextEditingController inputController = TextEditingController();

  String getUIDCurrentUser() {
    final User? user = _firebaseAuth.currentUser;
    return user!.uid;
  }

  Stream<QuerySnapshot> getMessage() {
    return messageService.getMessage(
        currentUserData[0], _firebaseAuth.currentUser!.uid);
  }

  void sendMessage() async {
    if (inputController.text.isNotEmpty) {
      await messageService.sendMessage(
          currentUserData[0], inputController.text);
      inputController.text = "";
    }
  }

  String convertTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    int hours = dateTime.hour;
    int minutes = dateTime.minute;
    return '${hours}:${minutes}';
  }
}
