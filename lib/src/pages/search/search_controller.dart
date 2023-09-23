import 'package:app_chat/src/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app_chat/src/config/app_theme.dart';
import 'package:app_chat/src/model/user_model.dart';
import 'package:app_chat/src/services/general/general_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  RxList listUser = [].obs;
  TextEditingController _textEditingController = TextEditingController();
  RxInt selectIndex = RxInt(-1);
  RxList<UserModel> listRequest = RxList<UserModel>([]);

  void findUserByName(String name) async {
    AppLoadingOverlayWidget.show();
    listUser.value = await generalService.findUserByName(name);
    selectIndex.value = -1;
    AppLoadingOverlayWidget.dismiss();
  }

  void logout() async {
    await authService.signOutAll();
  }

  Future<void> addFriendRequest(String receiverId) async {
    final User? user = _firebaseAuth.currentUser;
    await generalService.addFriendRequest(user!.uid, receiverId);
    listUser.refresh();
  }

  Future<void> getListRequest() async {
    AppLoadingOverlayWidget.show();
    final User? user = _firebaseAuth.currentUser;
    listRequest.value = await generalService.getListRequest(user!.uid);
    AppLoadingOverlayWidget.dismiss();
  }

  Future<void> acceptFriendRequest(String senderId) async {
    final User? user = _firebaseAuth.currentUser;
    await generalService.acceptFriendRequest(senderId, user!.uid);
    await getListRequest();
  }

  Future<void> rejectFriendRequest(String senderId) async {
    final User? user = _firebaseAuth.currentUser;
    await generalService.rejectFriendRequest(senderId, user!.uid);
    await getListRequest();
  }

  @override
  void onReady() async {
    await getListRequest();
  }
}
