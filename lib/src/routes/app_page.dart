import 'package:app_chat/src/pages/chat/chat_controller.dart';
import 'package:app_chat/src/pages/friends/components/friend_scan_qr.dart';
import 'package:app_chat/src/pages/home/home_controller.dart';
import 'package:app_chat/src/pages/list_chat/list_chat_controller.dart';
import 'package:app_chat/src/pages/login/login_controller.dart';
import 'package:app_chat/src/pages/register/register_controller.dart';
import 'package:app_chat/src/pages/setting/setting_controller.dart';
import 'package:app_chat/src/services/auth/auth_service.dart';
import 'package:app_chat/src/services/message/message_service.dart';
import 'package:get/get.dart';

import '../ext/app_controller.dart';
import '../services/general/general_service.dart';

part 'app_binding.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
        name: Routes.home,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.login,
        page: () => const LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: Routes.register,
        page: () => const RegisterPage(),
        binding: RegisterBinding()),
    GetPage(name: Routes.friendScanQr, page: () => const FriendScanQr()),
    GetPage(
        name: Routes.chatScreen,
        page: () => const ChatPage(),
        binding: ChatBinding()),
    GetPage(
        name: Routes.listChat,
        page: () => const ListChatPage(),
        binding: ListChatBinding()),
    GetPage(
        name: Routes.setting,
        page: () => const SettingPage(),
        binding: SettingBinding())
  ];
}
