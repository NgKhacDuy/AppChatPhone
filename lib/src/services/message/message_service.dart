import 'dart:convert';

import 'package:app_chat/src/model/list_chat.dart';
import 'package:app_chat/src/model/message.dart';
import 'package:app_chat/src/services/general/general_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:async/async.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utilities/utilities.dart';

class MessageService extends GetxService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GeneralService generalService = Get.find<GeneralService>();

  Future<void> sendMessage(String receiverId, String message,
      [String? iv, String? key]) async {
    User? user = _firebaseAuth.currentUser;
    final Timestamp timestamp = Timestamp.now();
    Message newMessage = Message(
        senderId: user!.uid,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp,
        iv: iv,
        key: key);
    List<String> ids = [user.uid, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    await _firestore
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('message')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<List<ListChatModel>> getListChat() async {
    try {
      List<ListChatModel> listChat = [];
      String currentUserId = _firebaseAuth.currentUser!.uid;
      final users = await _firestore.collection('users').get();

      for (var element in users.docs) {
        String id = element.data()['uid'];

        // Generate both possible groupChatIds
        String groupChatId1 = '${id}_$currentUserId';
        String groupChatId2 = '${currentUserId}_$id';

        // Check if chat room exists for each combination
        final docSnap1 = await _firestore
            .collection('chatRoom')
            .doc(groupChatId1)
            .collection('message')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();
        final docSnap2 = await _firestore
            .collection('chatRoom')
            .doc(groupChatId2)
            .collection('message')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();

        if (docSnap1.docs.isNotEmpty) {
          final data =
              docSnap1.docs.map((e) => ListChatModel.fromJson(e.data()));
          listChat.addAll(data);
        } else if (docSnap2.docs.isNotEmpty) {
          final data =
              docSnap2.docs.map((e) => ListChatModel.fromJson(e.data()));
          listChat.addAll(data);
        }
      }
      listChat.sort(
          (a, b) => a.lastMessageTimestamp.compareTo(b.lastMessageTimestamp));
      return listChat;
    } catch (e) {
      Logs.e(e);
      rethrow;
    }
  }
}
