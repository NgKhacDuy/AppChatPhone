part of 'friend_controller.dart';

class FriendPage extends GetView<FriendController> {
  const FriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          AppThemeExt.of.majorPaddingScale(6),
          AppThemeExt.of.majorPaddingScale(10),
          AppThemeExt.of.majorPaddingScale(6),
          AppThemeExt.of.majorPaddingScale(6)),
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Danh sách bạn bè',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.friendScanQr)?.then((value) async {
                      await controller.checkUserInList(value);
                    });
                  },
                  child: const FaIcon(FontAwesomeIcons.userPlus)),
              SizedBox(width: AppThemeExt.of.majorPaddingScale(6)),
              GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Mã QR của bạn'),
                            content: ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: QrImageView(
                                padding: EdgeInsets.zero,
                                data: controller.getUIDCurrentUser(),
                                version: QrVersions.auto,
                              ),
                            ),
                            actions: [
                              Container(
                                alignment: Alignment.center,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Tắt',
                                      style: TextStyle(fontSize: 16),
                                    )),
                              )
                            ],
                          );
                        });
                    // ,QrImageView(
                    //   data: '1234567890',
                    //   version: QrVersions.auto,
                    //   size: 200.0,
                    // );
                  },
                  child: const FaIcon(FontAwesomeIcons.qrcode)),
            ],
          ),
          SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Obx(
                () => ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          GestureDetector(
                            onTap: () {},
                            child: const FaIcon(FontAwesomeIcons.user),
                          ),
                          SizedBox(width: AppThemeExt.of.majorPaddingScale(2)),
                          Text(controller.listFriend[index].name)
                        ]),
                        GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.chatScreen, arguments: [
                                controller.listFriend[index].uid,
                                controller.listFriend[index].name
                              ]);
                            },
                            child: const FaIcon(FontAwesomeIcons.solidMessage))
                      ],
                    );
                  },
                  itemCount: controller.listFriend.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox();
                  },
                ),
              )),
          SizedBox(height: AppThemeExt.of.majorMarginScale(4)),
          const Text(
            'Danh sách lời mời kết bạn',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: AppThemeExt.of.majorMarginScale(2)),
          Obx(() => ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      padding:
                          EdgeInsets.all(AppThemeExt.of.majorMarginScale(6)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.of.tealColor[3]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(controller.listRequest[index].name),
                          Row(
                            children: [
                              InkWell(
                                child: FaIcon(
                                  FontAwesomeIcons.solidSquareCheck,
                                  size: 30,
                                  color: AppColors.of.greenColor,
                                ),
                                onTap: () async {
                                  await controller.acceptFriendRequest(
                                      controller.listRequest[index].uid);
                                },
                              ),
                              SizedBox(
                                  width: AppThemeExt.of.majorMarginScale(4)),
                              InkWell(
                                child: FaIcon(
                                  FontAwesomeIcons.solidRectangleXmark,
                                  size: 30,
                                  color: AppColors.of.redColor,
                                ),
                                onTap: () async {
                                  await controller.rejectFriendRequest(
                                      controller.listRequest[index].uid);
                                },
                              )
                            ],
                          )
                        ],
                      ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: AppThemeExt.of.majorMarginScale(4));
                },
                itemCount: controller.listRequest.length,
              )),
        ],
      ),
    );
  }
}
