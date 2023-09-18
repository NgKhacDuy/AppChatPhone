part of 'app_page.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController(), permanent: true);
    Get.put<AuthService>(AuthService(), permanent: true);
  }
}
