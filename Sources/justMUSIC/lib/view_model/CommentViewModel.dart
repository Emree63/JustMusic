import 'package:justmusic/model/mapper/CommentMapper.dart';

import '../model/Comment.dart';
import '../model/User.dart';
import '../services/CommentService.dart';
import '../services/NotificationService.dart';

class CommentViewModel {
  List<Comment> _comments = [];
  final CommentService _commentService = CommentService();
  final NotificationService _notificationService = NotificationService();

  // Constructor
  CommentViewModel();

  // Methods
  addComment(String text, String idPost, User receiver) async {
    try {
      print(receiver.token);
      await _commentService.createComment(text, idPost);
      _notificationService.sendNotifyComment(receiver.token, text);
    } catch (e) {
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
    } catch (e) {
      print(e);
      _comments = [];
      return [];
    }
  }
}
