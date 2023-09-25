part of 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SearchUserController>(() => SearchUserController());
    Get.lazyPut<FriendController>(() => FriendController());
  }
}
