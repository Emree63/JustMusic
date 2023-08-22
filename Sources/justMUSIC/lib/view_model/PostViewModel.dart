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

  Future<List<Post>> getPostsFriends() async {
    try {
      _postsFriends = [];
      var responseData = await _postService.getPostsFriends();
      List<String> ids = [];
      var postsFutures = responseData.map((value) {
        ids.add(value.data()["song_id"]);
        return PostMapper.toModel(value);
      }).toList();
      var posts = await Future.wait(postsFutures);
      List<Music> musics = await MyApp.musicViewModel.getMusicsWithIds(ids);
      for (int i = 0; i < posts.length; i++) {
        posts[i].music = musics[i];
      }
      _postsFriends = posts;
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
      var postsFutures = responseData.map((value) async {
        ids.add(value.data()["song_id"]);
        return await PostMapper.toModel(value);
      }).toList();
      var posts = await Future.wait(postsFutures);
      List<Music> musics = await MyApp.musicViewModel.getMusicsWithIds(ids);
      for (int i = 0; i < posts.length; i++) {
        posts[i].music = musics[i];
      }
      _bestPosts = posts;
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

  Future<List<bool>> recapSevenDays(String id) async {
    try {
      return await _postService.recapSevenDays(id);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> getAvailable() async {
    try {
      return await _postService.getAvailable(MyApp.userViewModel.userCurrent.id);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<String>> getLikesByPostId(String id) async {
    try {
      return await _postService.getLikesByPostId(id);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> addOrDeleteFavoritePost(String id) async {
    try {
      var bool = await _postService.addOrDeleteFavoritePost(id);
      print(bool);
      return bool;
    } catch (e) {
      print("haaaaaaaaa");
      rethrow;
    }
  }
}
