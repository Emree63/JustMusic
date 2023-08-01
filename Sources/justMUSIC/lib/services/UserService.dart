import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

class UserService {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getUsersByIdUnique(
      String uniqueId) async {
    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection("users")
        .where("unique_id", arrayContains: uniqueId)
        .get();

    var users = response.docs.where((doc) {
      String id = doc["id"];
      return id != MyApp.userViewModel.userCurrent.id;
    }).toList();

    return users;
  }
}
