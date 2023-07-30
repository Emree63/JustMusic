import 'dart:io';

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
      "selfie": null,
      "song_id": idMusic,
      "likes": 0
    };

    var postAdd = await MyApp.db.collection("posts").add(post);

    if (image != null) {
      var imageUrl = FirebaseStorage.instance.ref(id + postAdd.id);
      await imageUrl.putFile(image);
      postAdd.update({"selfie": imageUrl});
    }
  }

  deletePost() {}

  getPostsById(String id) {}
}
