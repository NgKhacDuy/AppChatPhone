part of 'app_page.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController(), permanent: true);
    Get.put<AuthService>(AuthService(), permanent: true);
  }
}
