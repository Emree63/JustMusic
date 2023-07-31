import 'dart:io';

import 'package:justmusic/model/Post.dart';
import 'package:justmusic/services/PostService.dart';
import 'package:tuple/tuple.dart';

import '../main.dart';
import '../model/Music.dart';
import '../model/mapper/PostMapper.dart';

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
  addPost(String? description, String idMusic, File? image, Tuple2<String, String>? location) async {
    await _postService.createPost(description, idMusic, image, location);
  }

  List<Post> getPostsFriends() {
    throw new Error();
  }

  List<Post> getMorePostsFriends() {
    throw new Error();
  }

  getBestPosts() async {
    try {
      var responseData = await _postService.getPopularPosts();
      List<String> ids = [];
      var postsFutures = responseData.map((value) {
        ids.add(value.data()["song_id"]);
        return PostMapper.toModel(value);
      }).toList();
      _bestPosts = await Future.wait(postsFutures);
      List<Music> musics = await MyApp.musicViewModel.getMusicsWithIds(ids);
      for (int i = 0; i < _bestPosts.length; i++) {
        _bestPosts[i].music = musics[i];
      }
    } catch (e) {
      print(e);
    }
  }

  List<Post> getMoreBestPosts() {
    throw new Error();
  }
}
