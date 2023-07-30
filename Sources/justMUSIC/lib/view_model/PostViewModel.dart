import 'package:justmusic/model/Post.dart';
import 'package:justmusic/services/PostService.dart';

class PostViewModel {
  List<Post> _postsFriends = [];
  List<Post> _bestPosts = [];
  final PostService _postService = PostService();

  // Constructor
  PostViewModel();

  // Getters and setters
  List<Post> get postsFriends => _postsFriends;

  List<Post> get bestPosts => _bestPosts;

  // Methods
  addPost(Post post) async {
    await _postService.createPost(post);
  }

  List<Post> getPostsFriends() {
    throw new Error();
  }

  List<Post> getMorePostsFriends() {
    throw new Error();
  }

  List<Post> getBestPosts() {
    throw new Error();
  }

  List<Post> getMoreBestPosts() {
    throw new Error();
  }
}
