part of 'list_chat_controller.dart';

class ListChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListChatController>(() => ListChatController());
  }
}
