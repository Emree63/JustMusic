import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/User.dart';
import '../main.dart';

class UserService {
  acceptFriend(User user, String idFriend) {
    MyApp.db.collection("users").doc(user.id).update({
      "friends": FieldValue.arrayUnion([idFriend])
    });
    MyApp.db.collection("users").doc(idFriend).update({
      "friends": FieldValue.arrayUnion([user.id])
    });
  }
}
