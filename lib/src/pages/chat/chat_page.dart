part of 'chat_controller.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.scrollDown());
    return AppMainPageWidget()
        .setAppBar(AppBarWidget()
            .setHeaderPage(controller.currentUserData[1])
            .setLeading(AppButtonAppBarWidget()
                .setPrefixIcon(const FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.white,
                ))
                .setOnPressed(() => Get.back())
                .build(context))
            .setHeaderPageColor(Colors.white)
            .setCenterTitle(true)
            .setBackgroundColor(const Color(0xff1d2f47))
            .build(context))
        .setResizeToAvoidBottomInset(true)
        .setBody(_body(context))
        .build(context);
  }

  Widget _body(BuildContext context) {
    return Container(
      color: const Color(0xff1d2f47),
      child: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildMessageInput(context)
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(AppThemeExt.of.majorScale(7)),
              bottomRight: Radius.circular(AppThemeExt.of.majorScale(7)))),
      child: GetBuilder<ChatController>(
        builder: (controller) {
          return StreamBuilder<QuerySnapshot>(
            stream: controller.getMessage(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.data!.docChanges.isNotEmpty) {
                controller.scrollDown();
              }
              return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                controller: controller.scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return _buildMessageItem(snapshot.data!.docs[index]);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == controller.getUIDCurrentUser())
        ? Alignment.centerRight
        : Alignment.centerLeft;
    var crossAlignment = (data['senderId'] == controller.getUIDCurrentUser())
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    var mainAlignment = (data['senderId'] == controller.getUIDCurrentUser())
        ? MainAxisAlignment.end
        : MainAxisAlignment.start;
    var isSender =
        (data['senderId'] == controller.getUIDCurrentUser()) ? true : false;
    var color = (data['senderId'] == controller.getUIDCurrentUser())
        ? 0xff1d2f47
        : 0xff475872;
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: mainAlignment,
            crossAxisAlignment: crossAlignment,
            children: [
              ChatBubble(
                message: data['message'],
                iv: data['iv'],
                keyIv: data['key'],
                isSender: isSender,
                color: color,
              ),
              Text(controller.convertTimestamp(data['timestamp']))
            ]),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppThemeExt.of.majorPaddingScale(4),
          vertical: AppThemeExt.of.majorPaddingScale(4)),
      child: Container(
        decoration: const BoxDecoration(
            color: Color(0xff475873),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Row(
          children: [
            Expanded(
              child: Focus(
                onFocusChange: (focus) {
                  controller.scrollDown();
                },
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Send something',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                  ),
                  controller: controller.inputController,
                ),
              ),
            ),
            Obx(() => IconButton(
                  onPressed: () {
                    controller.changeEncryptIcon();
                  },
                  icon: Icon(controller.isChooseEncrypt.value == false
                      ? Icons.enhanced_encryption
                      : Icons.no_encryption),
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  controller.sendMessage();
                  controller.scrollDown();
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
