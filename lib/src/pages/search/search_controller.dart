import 'package:app_chat/src/config/app_theme.dart';
import 'package:app_chat/src/services/general/general_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utilities/utilities.dart';

part 'search_binding.dart';
part 'search_page.dart';

class SearchUserController extends GetxController {
  final generalService = Get.find<GeneralService>();
  TextEditingController _textEditingController = TextEditingController();

  void findUserByName(String name) async {
    await generalService.findUserByName(name);
  }
}
