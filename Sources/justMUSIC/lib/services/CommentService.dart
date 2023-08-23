import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

class CommentService {
  createComment(String text, String idPost) async {
    var id = MyApp.userViewModel.userCurrent.id;
    final comment = <String, dynamic>{
      "user_id": id,
      "text": text,
      "date": DateTime.now(),
      "post_id": idPost
    };

    await MyApp.db.collection("comments").add(comment);
  }

  deleteComment(String id) async {
    await MyApp.db
        .collection("comments")
        .doc(id)
        .delete()
        .then((value) => print("Firestore deleted comment"))
        .catchError(
            (error) => print("Error deleting comment from Firestore: $error"));
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getCommentsByPostId(
      String id) async {
    var response = await FirebaseFirestore.instance
        .collection("comments")
        .where("post_id", isEqualTo: id)
        .orderBy("date", descending: true)
        .get();

    return response.docs;
  }
}
