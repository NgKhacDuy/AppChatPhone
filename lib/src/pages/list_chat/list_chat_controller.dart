import 'package:app_chat/src/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app_chat/src/config/app_theme.dart';
import 'package:app_chat/src/model/list_chat.dart';
import 'package:app_chat/src/services/general/general_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:utilities/utilities.dart';

import '../../services/auth/auth_service.dart';
import '../../services/message/message_service.dart';

part 'list_chat_binding.dart';
part 'list_chat_page.dart';

class ListChatController extends GetxController {
  final authService = Get.find<AuthService>();
  final messageService = Get.find<MessageService>();
  final generalService = Get.find<GeneralService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  RxList<ListChatModel> listChat = RxList([]);

  @override
  void onInit() async {
    super.onInit();
    fetchListChat();
  }

  Future<void> logout() async {
    await authService.signOutAll();
  }

  Future<void> fetchListChat() async {
    listChat.value = await messageService.getListChat();
  }

  String convertTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    int hours = dateTime.hour;
    int day = dateTime.day;
    int month = dateTime.month;
    int minutes = dateTime.minute;
    return '$day/$month $hours:$minutes';
  }

  Future<String> getUserName(String receiverId, String senderId) async {
    if (receiverId == _firebaseAuth.currentUser!.uid) {
      var user = await generalService.getUserById(senderId);
      return user.name;
    } else {
      var user = await generalService.getUserById(receiverId);
      return user.name;
    }
  }

  String renderLastMessage(String lastMessage, String receiverId) {
    if (lastMessage.length >= 20) {
      return receiverId == _firebaseAuth.currentUser!.uid
          ? '${lastMessage.substring(0, 20)}...'
          : 'Bạn: ${'${lastMessage.substring(0, 20)}...'}';
    }
    return lastMessage;
  }
}
