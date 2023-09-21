import 'package:algolia/algolia.dart';
import 'package:app_chat/src/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:utilities/utilities.dart';

import '../../env/algolia_key.dart';

class GeneralService extends GetxController {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Algolia algolia = Algolia.init(
      applicationId: AlgoliaKey().appId, apiKey: AlgoliaKey().apiKey);

  Future<List> findUserByName(String name) async {
    try {
      final User? user = _firebaseAuth.currentUser;
      List result = [];
      final query = algolia.instance.index('users_index').query(name);
      final snap = await query.getObjects();
      final resultUser = snap.hits;

      for (AlgoliaObjectSnapshot element in resultUser) {
        if (element.data['objectID'] == user?.uid) {
          continue;
        }
        final snapShot = await _firestore
            .collection('friendRequests')
            .where('senderId', isEqualTo: user?.uid)
            .where('receiverId', isEqualTo: element.data['objectID'])
            .get();
        element.data.addAll({'haveFriendRequest': snapShot.docs.isNotEmpty});
        result.add(element);
      }
      return result; // Return the result
    } on AlgoliaError catch (e) {
      Logs.e(e);
      throw e;
    }
  }

  Future<void> addFriendRequest(String senderId, String receiverId) async {
    try {
      final snapShot = await _firestore
          .collection('friendRequests')
          .where('senderId', isEqualTo: senderId)
          .where('receiverId', isEqualTo: receiverId)
          .get();
      if (snapShot.docs.isEmpty) {
        await _firestore
            .collection('friendRequests')
            .add({'senderId': senderId, 'receiverId': receiverId});
      }
    } on FirebaseException catch (e) {
      Logs.e(e);
    }
  }

  Future<List<UserModel>> getListRequest(String uid) async {
    List listRequest = [];
    try {
      QuerySnapshot friendRequestsnapShot = await _firestore
          .collection('friendRequests')
          .where('receiverId', isEqualTo: uid)
          .get();

      for (QueryDocumentSnapshot requestDoc in friendRequestsnapShot.docs) {
        String senderId = requestDoc['senderId'];
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(senderId).get();
        listRequest.add(userDoc.data());
      }

      return listRequest.map((e) {
        return UserModel.fromJson(e);
      }).toList();
    } on FirebaseException catch (e) {
      Logs.e(e);
      rethrow;
    }
  }
}
