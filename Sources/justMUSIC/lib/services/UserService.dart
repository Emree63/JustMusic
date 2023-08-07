 import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../main.dart';

class UserService {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getUsersByIdUnique(
      String uniqueId) async {
    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection("users")
        .where("unique_id", isGreaterThanOrEqualTo: uniqueId)
        .where("unique_id",
            isLessThanOrEqualTo: uniqueId + "zzzzzzzzzzzzzzzzzzzzzzzzzzzz")
        .limit(20)
        .get();
    var users = response.docs.where((doc) {
      String id = doc["unique_id"];
      return id != MyApp.userViewModel.userCurrent.uniquePseudo;
    }).toList();

    return users;
  }

  updateTokenNotify(String idUser, String token) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(idUser)
        .update({'token_notify': token}).then((_) {
      print("Mise à jour réussie !");
    }).catchError((error) {
      print("Erreur lors de la mise à jour : $error");
    });
  }

  addOrDeleteFriend(String id) async {
    var userRef =
        MyApp.db.collection("users").doc(MyApp.userViewModel.userCurrent.id);
    var actionUserRef = MyApp.db.collection("users").doc(id);

    if (MyApp.userViewModel.isFriend(id)) {
      await MyApp.db.runTransaction((transaction) async {
        transaction.update(userRef, {
          'followed': FieldValue.arrayRemove([id])
        });
        transaction.update(actionUserRef, {
          'followers': FieldValue.arrayRemove([userRef.id])
        });
      });
      MyApp.userViewModel.userCurrent.followed.remove(id);
    } else {
      await MyApp.db.runTransaction((transaction) async {
        transaction.update(userRef, {
          'followed': FieldValue.arrayUnion([id])
        });
        transaction.update(actionUserRef, {
          'followers': FieldValue.arrayUnion([userRef.id])
        });
      });
      MyApp.userViewModel.userCurrent.followed.add(id);
    }
  }

  updateImage(File image) async {
    var id = MyApp.userViewModel.userCurrent.id;
    var userRef = await MyApp.db.collection("posts").doc(MyApp.userViewModel.userCurrent.id);
    var imageRef = FirebaseStorage.instance.ref('$id.jpg');
    await imageRef.putFile(image);
    var imageUrl = await imageRef.getDownloadURL();
    userRef.update({"picture": imageUrl});
  }

  updatePseudo(String pseudo) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(MyApp.userViewModel.userCurrent.pp)
        .update({'pseudo': pseudo}).then((_) {
      print("Mise à jour réussie !");
    }).catchError((error) {
      print("Erreur lors de la mise à jour : $error");
    });
  }

}
