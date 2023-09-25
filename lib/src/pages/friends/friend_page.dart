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
                  onTap: () {}, child: const FaIcon(FontAwesomeIcons.userPlus)),
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
                            onTap: () {},
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
        ],
      ),
    );
  }
}
