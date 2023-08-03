import 'package:justmusic/model/mapper/CommentMapper.dart';

import '../model/Comment.dart';
import '../services/CommentService.dart';

class CommentViewModel {
  List<Comment> _comments = [];
  final CommentService _commentService = CommentService();

  // Constructor
  CommentViewModel();

  // Methods
  addComment(String text, String idPost) async {
    try {
      await _commentService.createComment(text,idPost);
    } catch(e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Comment>> getCommentsByPostId(String id) async {
    try {
      var responseData = await _commentService.getCommentsByPostId(id);
      var commentsFutures = responseData.map((value) async {
        return await CommentMapper.toModel(value);
      }).toList();
      _comments = await Future.wait(commentsFutures);
      return _comments;
    } catch(e) {
      print(e);
      _comments = [];
      return [];
    }
  }
}
