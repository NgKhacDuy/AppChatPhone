part of 'list_chat_controller.dart';

class ListChatPage extends GetView<ListChatController> {
  const ListChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: const Color(0xff1d2f47),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: AppThemeExt.of.majorMarginScale(8),
                left: AppThemeExt.of.majorMarginScale(4),
                right: AppThemeExt.of.majorMarginScale(4),
                bottom: AppThemeExt.of.majorMarginScale(4)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: const FaIcon(FontAwesomeIcons.arrowRightFromBracket,
                      color: Colors.white),
                  onTap: () {
                    controller.logout();
                  },
                ),
                const Text(
                  'Fast Chat',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                const FaIcon(
                  FontAwesomeIcons.gear,
                  color: Colors.white,
                )
              ],
            ),
          ),
          test(context)
          // listChat(context)
        ],
      ),
    );
  }

  Widget test(BuildContext context) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.only(left: AppThemeExt.of.majorPaddingScale(3)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(AppThemeExt.of.majorScale(6)),
                  topLeft: Radius.circular(AppThemeExt.of.majorScale(6)))),
          child: Obx(
            () => SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.listChat.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        controller.goToChatPage(
                            controller.checkSelfUid(
                                controller.listChat[index].senderId,
                                controller.listChat[index].receiverId),
                            await controller.getUserName(
                                controller.listChat[index].senderId,
                                controller.listChat[index].receiverId));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: EdgeInsets.all(
                                  AppThemeExt.of.majorPaddingScale(2)),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black)),
                              child: const FaIcon(FontAwesomeIcons.user,
                                  color: Colors.black)),
                          SizedBox(width: AppThemeExt.of.majorPaddingScale(3)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder<String>(
                                future: controller.getUserName(
                                    controller.listChat[index].receiverId,
                                    controller.listChat[index].senderId),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot1) {
                                  if (snapshot1.hasData) {
                                    return Text(snapshot1.data!,
                                        style: TextStyle(color: Colors.black));
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),
                              Row(
                                children: [
                                  Text(controller.renderLastMessage(
                                      controller.listChat[index].lastMessage,
                                      controller.listChat[index].receiverId)),
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                                right: AppThemeExt.of.majorPaddingScale(4)),
                            child: Text(
                              controller.convertTimestamp(controller
                                  .listChat[index].lastMessageTimestamp),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: AppThemeExt.of.majorMarginScale(3));
                  },
                )),
          )),
    );
  }
}
