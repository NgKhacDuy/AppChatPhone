part of 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FriendController>(() => FriendController());
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut<ListChatController>(() => ListChatController());
  }
}
