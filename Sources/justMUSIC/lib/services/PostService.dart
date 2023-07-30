import '../main.dart';
import '../model/Post.dart';
import '../model/mapper/PostMapper.dart';

class PostService {
  createPost(Post post) {
    MyApp.db
        .collection("posts")
        .add(PostMapper.toFirebase(post))
        .then((value) => print("Post Added"))
        .catchError((error) => print("Failed to add post: $error"));
  }

  deletePost() {}

  getPostsById(String id) {}
}
