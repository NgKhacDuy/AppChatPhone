import 'package:cloud_firestore/cloud_firestore.dart';

class ListChatModel {
  String receiverId;
  String senderId;
  String lastMessage;
  Timestamp lastMessageTimestamp;

  ListChatModel({
    required this.senderId,
    required this.receiverId,
    required this.lastMessage,
    required this.lastMessageTimestamp,
  });

  factory ListChatModel.fromJson(Map<String, dynamic> json) {
    return ListChatModel(
        senderId: json['senderId'],
        receiverId: json['receiverId'],
        lastMessage: json['message'],
        lastMessageTimestamp: json['timestamp']);
  }
}
