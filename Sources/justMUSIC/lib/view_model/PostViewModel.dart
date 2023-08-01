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
  addPost(String? description, String idMusic, File? image,
      Tuple2<String, String>? location) async {
    await _postService.createPost(description, idMusic, image, location);
  }

  Future<List<Post>> getPostsFriends() async {
    try {
      var responseData = await _postService.getPostsFriends();
      List<String> ids = [];
      var postsFutures = responseData.map((value) {
        ids.add(value.data()["song_id"]);
        return PostMapper.toModel(value);
      }).toList();
      List<Music> musics = await MyApp.musicViewModel.getMusicsWithIds(ids);
      for (int i = 0; i < _postsFriends.length; i++) {
        _postsFriends[i].music = musics[i];
      }
      return _postsFriends;
    } catch (e) {
      print(e);
      _postsFriends = [];
      return [];
    }
  }

  List<Post> getMorePostsFriends() {
    throw new Error();
  }

  Future<List<Post>> getBestPosts() async {
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
      return _bestPosts;
    } catch (e) {
      print(e);
      _bestPosts = [];
      return [];
    }
  }

  List<Post> getMoreBestPosts() {
    throw new Error();
  }

  Future<bool> getAvailable() async {
    try {
      return await _postService
          .getAvailable(MyApp.userViewModel.userCurrent.id);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
