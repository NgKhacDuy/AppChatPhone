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

  List result = [];
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
        Logs.e(element.data);
        result.add(element);
      }
      return result; // Return the result
    } on AlgoliaError catch (e) {
      Logs.e(e);
      throw e;
    }
  }
}
