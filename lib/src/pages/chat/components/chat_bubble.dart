import 'package:app_chat/src/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app_chat/src/config/app_theme.dart';
import 'package:app_chat/src/pages/chat/chat_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:utilities/utilities.dart';

class ChatBubble extends GetView<ChatController> {
  final String message;
  final RxString encryptMessage;
  final String? iv;
  final String? keyIv;
  final bool isSender;
  final int color;
  ChatBubble(
      {super.key,
      required this.message,
      required this.color,
      this.iv,
      this.keyIv,
      required this.isSender})
      : encryptMessage = message.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppThemeExt.of.majorScale(3)),
      decoration: BoxDecoration(
          color: Color(color),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppThemeExt.of.majorScale(2)),
            topRight: Radius.circular(AppThemeExt.of.majorScale(2)),
            bottomLeft: isSender == true
                ? Radius.circular(AppThemeExt.of.majorScale(2))
                : Radius.zero,
            bottomRight: isSender == true
                ? Radius.zero
                : Radius.circular(AppThemeExt.of.majorScale(2)),
          )),
      child: GestureDetector(
          onLongPress: () {
            if (iv != null) {
              AppDefaultDialogWidget()
                  .setTitle('Giải mã')
                  .setContent('Bạn có muốn giải mã ?')
                  .setAppDialogType(AppDialogType.confirm)
                  .setAppDialogButtonType(AppDialogButtonType.standard)
                  .setPositiveText('Có')
                  .setOnPositive(() {
                    encryptMessage.value = controller.decryption(
                        encryptMessage.value, iv!, keyIv!);
                  })
                  .setNegativeText('Không')
                  .buildDialog(context)
                  .show();
            }
          },
          child: Obx(
            () => Text(
              encryptMessage.value,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          )),
    );
  }
}
