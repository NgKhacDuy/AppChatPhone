import 'dart:typed_data';

import 'package:app_chat/src/components/main/page/app_main_page_base_builder.dart';
import 'package:app_chat/src/pages/friends/components/qr_overlay.dart';
import 'package:app_chat/src/pages/friends/friend_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:utilities/utilities.dart';

class FriendScanQr extends GetView<FriendController> {
  const FriendScanQr({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget().setBody(_body(context)).build(context);
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          onDetect: controller.foundBarCode,
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.normal,
            facing: CameraFacing.back,
            torchEnabled: false,
          ),
        ),
        QRScannerOverlay(
          overlayColour: Colors.black.withOpacity(0.5),
        ),
      ],
    );
  }
}
