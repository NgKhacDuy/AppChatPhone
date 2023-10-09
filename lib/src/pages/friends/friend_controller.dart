import 'package:app_chat/src/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app_chat/src/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app_chat/src/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app_chat/src/config/app_theme.dart';
import 'package:app_chat/src/model/user_model.dart';
import 'package:app_chat/src/pages/friends/components/friend_scan_qr.dart';
import 'package:app_chat/src/services/general/general_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:utilities/utilities.dart';

import '../../routes/app_page.dart';

part 'friend_binding.dart';
part 'friend_page.dart';

class FriendController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final generalService = Get.find<GeneralService>();
  RxList<UserModel> listFriend = RxList<UserModel>([]);
  RxBool _screenOpened = RxBool(false);
  RxList<UserModel> listRequest = RxList<UserModel>([]);

  @override
  void onInit() async {
    initFetch();
    super.onInit();
  }

  Future<void> initFetch() async {
    await getListFriend();
    await getListRequest();
  }

  Future<void> acceptFriendRequest(String senderId) async {
    try {
      final User? user = _firebaseAuth.currentUser;
      await generalService.acceptFriendRequest(senderId, user!.uid);
      await getListRequest();
      AppSnackBarWidget()
          .setContent(Text('Bạn đã chấp nhận lời mời kết bạn'))
          .showSnackBar(Get.context!);
      initFetch();
    } catch (e) {}
  }

  Future<void> rejectFriendRequest(String senderId) async {
    final User? user = _firebaseAuth.currentUser;
    await generalService.rejectFriendRequest(senderId, user!.uid);
    await getListRequest();
  }

  Future<void> getListRequest() async {
    AppLoadingOverlayWidget.show();
    final User? user = _firebaseAuth.currentUser;
    listRequest.value = await generalService.getListRequest(user!.uid);
    AppLoadingOverlayWidget.dismiss();
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

  String? getNameCurrentUser() {
    final User? user = _firebaseAuth.currentUser;
    return user?.displayName;
  }

  void foundBarCode(BarcodeCapture capture) {
    if (!_screenOpened.value) {
      final List<Barcode> barcodes = capture.barcodes;
      for (final barcode in barcodes) {
        Get.back(result: barcode.rawValue);
      }
    }
  }

  Future<void> checkUserInList(String uid) async {
    try {
      AppLoadingOverlayWidget.show();
      var isFriend = await generalService.checkUserInListFriend(uid);
      UserModel user = await generalService.getUserById(uid);
      AppLoadingOverlayWidget.dismiss();
      if (isFriend) {
        AppDefaultDialogWidget()
            .setContent(
                'Bạn và người dùng này đã là bạn bè từ trước, vui lòng quét mã QR người dùng khác')
            .setAppDialogButtonType(AppDialogButtonType.standard)
            .setAppDialogType(AppDialogType.success)
            .setIsHaveCloseIcon(true)
            .buildDialog(Get.context!)
            .show();
      } else {
        AppDefaultDialogWidget()
            .setContent('Bạn có muốn kết bạn với ${user.name} không?')
            .setAppDialogButtonType(AppDialogButtonType.standard)
            .setAppDialogType(AppDialogType.confirm)
            .setPositiveText('Đồng ý')
            .setNegativeText('Không')
            .setOnPositive(() async {
              await addRequest(uid);
            })
            .setOnNegative(() {})
            .setIsHaveCloseIcon(true)
            .buildDialog(Get.context!)
            .show();
      }
    } catch (e) {
      Logs.e(e);
      AppLoadingOverlayWidget.dismiss();
      AppDefaultDialogWidget()
          .setContent('Đã có lỗi xảy ra, vui lòng thử lại hoặc quét mã QR khác')
          .setAppDialogButtonType(AppDialogButtonType.danger)
          .setAppDialogType(AppDialogType.error)
          .setIsHaveCloseIcon(true)
          .buildDialog(Get.context!)
          .show();
    }
  }

  Future<void> addRequest(String uid) async {
    try {
      await generalService.addFriendRequest(
          _firebaseAuth.currentUser!.uid, uid);
      AppSnackBarWidget()
          .setContent(Text('Đã gửi lời mời kết bạn'))
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .setAppSnackBarType(AppSnackBarType.toastMessage)
          .showSnackBar(Get.context!);
    } catch (e) {
      Logs.e(e);
      AppSnackBarWidget()
          .setContent(Text('Đã có lỗi xảy ra, vui lòng thử lại'))
          .setAppSnackBarStatus(AppSnackBarStatus.error)
          .setAppSnackBarType(AppSnackBarType.toastMessage)
          .showSnackBar(Get.context!);
    }
  }
}
