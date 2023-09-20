import 'package:app_chat/src/pages/home/home_controller.dart';
import 'package:app_chat/src/pages/login/login_controller.dart';
import 'package:app_chat/src/pages/register/register_controller.dart';
import 'package:app_chat/src/pages/search/search_controller.dart';
import 'package:app_chat/src/services/auth/auth_service.dart';
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
    GetPage(
        name: Routes.search,
        page: () => const SearchPage(),
        binding: SearchBinding()),
  ];
}
