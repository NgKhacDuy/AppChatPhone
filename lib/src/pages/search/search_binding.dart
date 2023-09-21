part of 'search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchUserController>(() => SearchUserController());
  }
}
