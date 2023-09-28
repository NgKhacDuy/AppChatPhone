import 'package:app_chat/src/config/app_theme.dart';
import 'package:flutter/cupertino.dart';

class ChatBubble extends StatelessWidget {
  final String message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppThemeExt.of.majorScale(3)),
      decoration: BoxDecoration(
          color: AppColors.of.tealColor,
          borderRadius: BorderRadius.circular(AppThemeExt.of.majorScale(2))),
      child: Text(
        message,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
