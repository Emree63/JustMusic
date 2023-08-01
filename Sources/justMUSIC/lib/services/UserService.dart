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

    return users;
  }

  addOrDeleteFriend(String id) async {

    var userRef = MyApp.db.collection("users").doc(MyApp.userViewModel.userCurrent.id);

    if (MyApp.userViewModel.isFriend(id)) {
      await MyApp.db.runTransaction((transaction) async {
        transaction.update(userRef, {'followed': FieldValue.arrayRemove([id])});
      });
      MyApp.userViewModel.userCurrent.followed.remove(id);
    } else {
      await MyApp.db.runTransaction((transaction) async {
        transaction.update(userRef, {'followed': FieldValue.arrayUnion([id])});
      });
      MyApp.userViewModel.userCurrent.followed.add(id);
    }
  }

}
