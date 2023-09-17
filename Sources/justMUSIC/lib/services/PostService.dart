import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../main.dart';

class PostService {
  createPost(String? description, String idMusic, File? image,
      Tuple2<String, String>? location) async {
    var id = MyApp.userViewModel.userCurrent.id;
    final post = <String, dynamic>{
      "user_id": id,
      "description": description,
      "date": DateTime.now(),
      "place": [location?.item1, location?.item2],
      "song_id": idMusic,
      "likes": []
    };

    var postAdd = await MyApp.db.collection("posts").add(post);

    var userRef = MyApp.db.collection("users").doc(id);

    await MyApp.db.runTransaction((transaction) async {
      var userSnapshot = await transaction.get(userRef);
      if (userSnapshot.exists) {
        int currentNbCapsules = userSnapshot.data()?['nbCapsules'] ?? 0;
        transaction.update(userRef, {'nbCapsules': currentNbCapsules + 1});
        MyApp.userViewModel.userCurrent.capsules++;
      }
    });

    if (image != null) {
      var imageRef = FirebaseStorage.instance.ref('$id${postAdd.id}.jpg');
      await imageRef.putFile(image);
      var imageUrl = await imageRef.getDownloadURL();
      postAdd.update({"selfie": imageUrl});
    }
  }

  deletePost() {}

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getPopularPosts(
      {int limit = 10,
      QueryDocumentSnapshot<Map<String, dynamic>>? offset}) async {
    QuerySnapshot<Map<String, dynamic>> response;
    response = await FirebaseFirestore.instance
        .collection("posts")
        .orderBy("date")
        .limit(limit)
        .get();

    var filteredPosts = response.docs.where((doc) {
      String user = doc["user_id"];
      return user != MyApp.userViewModel.userCurrent.id;
    }).toList();
    return filteredPosts;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getPostsFriends(
      {int limit = 10, int offset = 0}) async {
    var response = await FirebaseFirestore.instance
        .collection("posts")
        .where("user_id", whereIn: [
          MyApp.userViewModel.userCurrent.id,
          ...MyApp.userViewModel.userCurrent.followed
        ])
        .orderBy("date")
        .limit(limit)
        .get();

    return response.docs;
  }

  Future<bool> getAvailable(String idUser) async {
    DateTime today = DateTime.now();

    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection("posts")
        .where("user_id", isEqualTo: idUser)
        .get();

    bool isTodayAvailable = response.docs.any((doc) {
      DateTime date = doc["date"].toDate();
      return date.day == today.day &&
          date.month == today.month &&
          date.year == today.year;
    });

    return !isTodayAvailable;
  }

  Future<List<bool>> recapSevenDays(String id) async {
    List<bool> recapList = [];

    DateTime sevenDaysAgo = DateTime.now().subtract(Duration(days: 6));

    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection("posts")
        .where("user_id", isEqualTo: id)
        .get();

    List<Map<String, dynamic>?> postList = response.docs
        .map((DocumentSnapshot<Map<String, dynamic>> doc) => doc.data())
        .toList();

    for (int i = 0; i < 7; i++) {
      DateTime date = sevenDaysAgo.add(Duration(days: i));
      bool postExists = postList.any((post) =>
          post?["date"] != null &&
          post?["date"].toDate().year == date.year &&
          post?["date"].toDate().month == date.month &&
          post?["date"].toDate().day == date.day);

      recapList.add(postExists);
    }

    return recapList;
  }

  Future<List<String>> getLikesByPostId(String id) async {
    var response =
        await FirebaseFirestore.instance.collection("posts").doc(id).get();
    if (response.exists) {
      var musicFavorite = response.get("likes");
      return List.from(musicFavorite);
    } else {
      return [];
    }
  }

  Future<bool> addOrDeleteFavoritePost(String id) async {
    final idUser = MyApp.userViewModel.userCurrent.id;
    var postRef = await FirebaseFirestore.instance.collection("posts").doc(id);
    var response = await postRef.get();

    List<String> likes = List.from(response.get("likes"));

    if (!likes.contains(idUser)) {
      likes.add(idUser);
      await postRef.update({"likes": likes});
      return false;
    } else {
      likes.remove(idUser);
      await postRef.update({"likes": likes});
      return true;
    }
  }
}
