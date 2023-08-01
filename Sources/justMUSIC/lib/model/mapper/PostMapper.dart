import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';

import '../../main.dart';
import '../Post.dart';
import '../User.dart';

class PostMapper {
  static Future<Post> toModel (
      DocumentSnapshot<Map<String, dynamic>> snapshot) async {
    final data = snapshot.data();
      User? user = await MyApp.userViewModel.getUser(data?['user_id']);
      return Post(
          snapshot.id,
          user!,
          data?["description"],
          Tuple2(data?["place"][0], data?["place"][1]),
          data?["likes"],
          data?["selfie"],
          data?["date"].toDate());
  }
}
