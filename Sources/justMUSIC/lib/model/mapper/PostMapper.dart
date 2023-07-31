import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';

import '../Post.dart';

class PostMapper {
  static Post toModel(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Post(
        snapshot.id,
        data?["user_id"],
        data?["description"],
        data?["song_id"],
        Tuple2(data?["place"][0], data?["place"][1]),
        data?["likes"],
        data?["selfie"],
        data?["date"].toDate());
  }
}
