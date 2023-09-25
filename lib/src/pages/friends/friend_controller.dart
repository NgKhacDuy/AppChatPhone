import 'package:app_chat/src/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app_chat/src/config/app_theme.dart';
import 'package:app_chat/src/model/user_model.dart';
import 'package:app_chat/src/services/general/general_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:utilities/utilities.dart';

part 'friend_binding.dart';
part 'friend_page.dart';

class FriendController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final generalService = Get.find<GeneralService>();
  RxList<UserModel> listFriend = RxList<UserModel>([]);

  @override
  void onInit() async {
    await getListFriend();
    super.onInit();
  }

  Future<void> getListFriend() async {
    AppLoadingOverlayWidget.show();
    final User? user = _firebaseAuth.currentUser;
    List<UserModel> listResult = await generalService.getListFriends(user!.uid);
    listFriend.assignAll(listResult);
    AppLoadingOverlayWidget.dismiss();
  }

  String getUIDCurrentUser() {
    final User? user = _firebaseAuth.currentUser;
    return user!.uid;
  }
}
