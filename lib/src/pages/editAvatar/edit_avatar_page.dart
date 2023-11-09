part of 'edit_avatar_controller.dart';

class EditAvatarPage extends GetView<EditAvatarController> {
  const EditAvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget()
        .setAppBar(
          AppBarWidget()
              .setHeaderPage('Đổi avatar của bạn')
              .setCenterTitle(true)
              .setActions(
            [
              Obx(
                () => controller.newAvatarUrl.value !=
                        controller.userModel.imgPath
                    ? IconButton(
                        onPressed: () =>
                            controller.showDialogSaveAvatar(context),
                        icon: const Icon(Icons.save_rounded))
                    : const SizedBox(),
              ),
            ],
          ).build(context),
        )
        .setBody(
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppThemeExt.of.majorPaddingScale(4)),
            child: Column(
              children: [
                Obx(
                  () => controller.newAvatarUrl.value ==
                          controller.userModel.imgPath
                      ? AppAvatarNetworkWidget()
                          .setLink(controller.newAvatarUrl.value)
                          .setSize(AppAvatarSize.extraExtraLarge)
                          .build(context)
                      : AppAvatarFileWidget()
                          .setFile(File(controller.newAvatarUrl.value!))
                          .setSize(AppAvatarSize.extraExtraLarge)
                          .build(context),
                ),
                AppTextHeading1Widget()
                    .setText(controller.userModel.name)
                    .build(context),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: AppOutlinedButtonWidget()
                      .setButtonText('Chọn từ thư viên')
                      .setOnPressed(
                    () {
                      controller.chooseAvtFromGallery();
                    },
                  ).build(context),
                ),
                SizedBox(height: AppThemeExt.of.majorScale(2)),
                SizedBox(
                  width: double.infinity,
                  child: AppOutlinedButtonWidget()
                      .setButtonText('Chụp ảnh mới')
                      .setOnPressed(
                    () {
                      controller.takeNewPhoto();
                    },
                  ).build(context),
                ),
              ],
            ),
          ),
        )
        .build(context);
  }
}
