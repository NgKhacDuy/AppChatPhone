part of 'edit_avatar_controller.dart';

class EditAvatarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAvatarController>(() => EditAvatarController());
  }
}
