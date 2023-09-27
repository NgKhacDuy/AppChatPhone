part of 'friend_controller.dart';

class FriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FriendController>(() => FriendController());
  }

}