import 'package:cloud_firestore/cloud_firestore.dart';

import '../../main.dart';
import '../Comment.dart';
import '../User.dart';

class CommentMapper {
  static Future<Comment> toModel(DocumentSnapshot<Map<String, dynamic>> snapshot) async {
    final data = snapshot.data();
    User? user = await MyApp.userViewModel.getUser(data?['user_id']);
    return Comment(
        snapshot.id,
        user!,
        data?["text"],
        data?["date"]);
  }
}
