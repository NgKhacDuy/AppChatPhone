import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

import '../../components/main/appBar/app_bar_base_builder.dart';
import '../../components/main/avatar/app_avatar_base_builder.dart';
import '../../components/main/button/app_button_base_builder.dart';
import '../../components/main/dialog/app_dialog_base_builder.dart';
import '../../components/main/overlay/app_loading_overlay_widget.dart';
import '../../components/main/page/app_main_page_base_builder.dart';
import '../../components/main/text/app_text_base_builder.dart';
import '../../config/app_theme.dart';
import '../../model/user_model.dart';
import '../../services/general/general_service.dart';
import 'package:uuid/uuid.dart';

part 'edit_avatar_binding.dart';
part 'edit_avatar_page.dart';

class EditAvatarController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final GeneralService generalService = Get.find<GeneralService>();
  final UserModel userModel = Get.arguments;

  final _picker = ImagePicker();
  late XFile? pickedImage;
  Rxn<String> newAvatarUrl = Rxn<String>();
  var uuid = Uuid();
  EditAvatarController();

  @override
  void onInit() async {
    super.onInit();
    newAvatarUrl.value = userModel.imgPath;
  }

  Future<void> chooseAvtFromGallery() async {
    pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Logs.e(pickedImage!.path);
      newAvatarUrl.value = pickedImage!.path;
    }
  }

  Future<void> takeNewPhoto() async {
    pickedImage = await _picker.pickImage(
        source: ImageSource.camera, maxHeight: 200, maxWidth: 200);
    if (pickedImage != null) {
      Logs.e(pickedImage!.path);
      newAvatarUrl.value = pickedImage!.path;
    }
  }

  void showDialogSaveAvatar(BuildContext context) {
    AppDefaultDialogWidget()
        .setTitle('Xác nhận đổi avatar')
        .setContent('Bạn có muốn chắc chắn đổi avatar')
        .setAppDialogType(AppDialogType.confirm)
        .setPositiveText('Đồng ý')
        .setOnPositive(() {
          executeChangeAvatar();
        })
        .setNegativeText('Huỷ')
        .setOnNegative(() {})
        .buildDialog(context)
        .show();
  }

  void executeChangeAvatar() async {
    try {
      final imageName = uuid.v4();
      TaskSnapshot uploadTask;
      AppLoadingOverlayWidget.show();
      final file = File(newAvatarUrl.value!);
      final ref = _firebaseStorage.ref().child(imageName);
      uploadTask = await ref.putFile(file);
      final urlDownload = await uploadTask.ref.getDownloadURL();
      Logs.e(urlDownload);
      await generalService.addImgUser(urlDownload);
      AppLoadingOverlayWidget.dismiss();
      Get.back(result: urlDownload);
    } catch (e) {
      AppLoadingOverlayWidget.dismiss();
      Logs.e(e);
      return null;
    }
  }
}
