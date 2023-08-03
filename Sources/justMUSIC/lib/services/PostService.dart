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
      "likes": 0
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
      {int limit = 10, int offset = 0}) async {
    DateTime twentyFourHoursAgo = DateTime.now().subtract(Duration(hours: 24));
    Timestamp twentyFourHoursAgoTimestamp =
        Timestamp.fromDate(twentyFourHoursAgo);

    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection("posts")
        .where("date", isGreaterThan: twentyFourHoursAgoTimestamp)
        .limit(limit)
        .get();

    var filteredPosts = response.docs.where((doc) {
      String user = doc["user_id"];
      return user != MyApp.userViewModel.userCurrent.id;
    }).toList();
    return filteredPosts;
  }

  Timestamp _getTwentyFourHoursAgoTimestamp() {
    DateTime twentyFourHoursAgo = DateTime.now().subtract(Duration(hours: 24));
    return Timestamp.fromDate(twentyFourHoursAgo);
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getPostsFriends(
      {int limit = 10, int offset = 0}) async {
    var timestamp = _getTwentyFourHoursAgoTimestamp();
    var response = await FirebaseFirestore.instance
        .collection("posts")
        .where("user_id", whereIn: MyApp.userViewModel.userCurrent.followed)
        .where("date", isGreaterThan: timestamp)
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
      DateTime date = doc["date"].toDate(); // Assuming the field name is "date"
      return date.day == today.day &&
          date.month == today.month &&
          date.year == today.year;
    });

    return !isTodayAvailable;
  }
}
