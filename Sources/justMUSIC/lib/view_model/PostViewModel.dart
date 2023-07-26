import 'package:justmusic/model/Post.dart';

class PostViewModel {
  List<Post> _postsFriends = [];
  List<Post> _bestPosts = [];

  // Constructor
  PostViewModel();

  // Getters and setters
  List<Post> get postsFriends => _postsFriends;

  List<Post> get bestPosts => _bestPosts;

  // Methods
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
