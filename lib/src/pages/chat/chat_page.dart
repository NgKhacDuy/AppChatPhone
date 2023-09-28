part of 'chat_controller.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget()
        .setAppBar(AppBarWidget()
            .setHeaderPage(controller.currentUserData[1])
            .setCenterTitle(true)
            .setBackgroundColor(AppColors.of.tealColor[5])
            .build(context))
        .setResizeToAvoidBottomInset(true)
        .setBody(_body(context))
        .build(context);
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildMessageList()),
        _buildMessageInput(context)
      ],
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
        stream: controller.getMessage(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListView(
            children:
                snapshot.data!.docs.map((e) => _buildMessageItem(e)).toList(),
          );
        });
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
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Send something',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: AppThemeExt.of.majorPaddingScale(2))),
                controller: controller.inputController,
              ),
            ),
            IconButton(
                onPressed: () {
                  controller.sendMessage();
                },
                icon: const Icon(Icons.send))
          ],
        ),
      ),
    );
  }
}
