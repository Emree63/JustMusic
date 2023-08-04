import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

class MusicService {
  Future<dynamic> getFavoriteMusicsByUserId(String id) async {
    var response = await FirebaseFirestore.instance.collection("users").doc(id).get();
    if (response.exists) {
      var musicFavorite = response.get("saved_musics");
      return List.from(musicFavorite);
    } else {
      return [];
    }
  }

  Future<bool> addOrDeleteFavoriteMusic(String id) async {
    var userRef = await FirebaseFirestore.instance.collection("users").doc(MyApp.userViewModel.userCurrent.id);
    var response = await userRef.get();

    List<dynamic> musicFavorite = List.from(response.get("saved_musics"));
    if (!musicFavorite.contains(id)) {
      musicFavorite.add(id);
      await userRef.update({"saved_musics": musicFavorite});
      return false;
    } else {
      musicFavorite.remove(id);
      await userRef.update({"saved_musics": musicFavorite});
      return true;
    }
  }
}
