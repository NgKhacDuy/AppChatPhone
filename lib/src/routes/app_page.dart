import 'package:app_chat/src/pages/home/home_controller.dart';
import 'package:get/get.dart';

part 'app_binding.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(name: Routes.home, page: () => const HomePage())
  ];
}
