import '../Post.dart';

class PostMapper {
  static Map<String, dynamic> toFirebase(Post post) {
    return {
      "user_id": post.idUser,
      "description": post.description ?? "",
      "date": post.date,
      "place": post.location ?? "",
      "selfie": post.selfie ?? "",
      "song_id": post.idMusic,
      "likes": post.nblikes
    };
  }
}