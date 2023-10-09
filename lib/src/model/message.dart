import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  final String? iv;
  final String? key;

  Message(
      {this.iv,
      this.key,
      required this.senderId,
      required this.receiverId,
      required this.message,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'iv': iv,
      'key': key
    };
  }
}
