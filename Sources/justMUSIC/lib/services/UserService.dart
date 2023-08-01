import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

class UserService {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getUsersByIdUnique(String uniqueId) async {
    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore.instance
        .collection("users")
        .where("unique_id", isGreaterThanOrEqualTo: uniqueId)
        .where("unique_id", isLessThanOrEqualTo: uniqueId + "zzzzzzzzzzzzzzzzzzzzzzzzzzzz")
        .limit(20)
        .get();
    var users = response.docs.where((doc) {
      String id = doc["unique_id"];
      return id != MyApp.userViewModel.userCurrent.uniquePseudo;
    }).toList();
    print("cc34" + users.toString());

    return users;
  }
}
