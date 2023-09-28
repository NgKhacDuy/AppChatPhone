part of 'app_page.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController(), permanent: true);
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<GeneralService>(GeneralService(), permanent: true);
    Get.put<MessageService>(MessageService(), permanent: true);
  }
}
