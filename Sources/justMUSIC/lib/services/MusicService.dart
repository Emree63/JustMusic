import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

class MusicService {
  Future<dynamic> getFavoriteMusicsByUserId(String id) async {
    var response =
        await FirebaseFirestore.instance.collection("users").doc(id).get();
    if (response.exists) {
      var musicFavorite = response.get("musics_likes");
      return List.from(musicFavorite);
    } else {
      return [];
    }
  }

  deleteFavoriteMusic(String id) async {
    var userRef = await FirebaseFirestore.instance
        .collection("users")
        .doc(MyApp.userViewModel.userCurrent.id);
    var response = await userRef.get();

    List<dynamic> musicFavorite = List.from(response.get("musics_likes"));
    if (!musicFavorite.contains(id)) {
      musicFavorite.remove(id);
      await userRef.update({"musics_likes": musicFavorite});
    } else {
      print("Delete error: The music is not in the user's favorite music list");
    }
  }

  Future<bool> addOrDeleteFavoriteMusic(String id) async {
    var userRef = await FirebaseFirestore.instance
        .collection("users")
        .doc(MyApp.userViewModel.userCurrent.id);
    var response = await userRef.get();

    List<dynamic> musicFavorite = List.from(response.get("musics_likes"));
    if (!musicFavorite.contains(id)) {
      musicFavorite.add(id);
      await userRef.update({"musics_likes": musicFavorite});
      return false;
    } else {
      musicFavorite.remove(id);
      await userRef.update({"musics_likes": musicFavorite});
      return true;
    }
  }
}
