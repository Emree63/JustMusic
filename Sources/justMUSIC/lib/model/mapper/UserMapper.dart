import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:justmusic/model/User.dart';

class UserMapper {
  static User toModel(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return User(
        snapshot.id,
        data?["pseudo"],
        data?["unique_id"],
        data?["mail"],
        data?["picture"],
        data?["token_notify"],
        List<String>.from(data?["followers"] as List),
        List<String>.from(data?["musics_likes"] as List),
        data?["nbCapsules"] ?? 0,
        List<String>.from(data?["followed"] as List));
  }
/*
  static Map<String, dynamic> toFirebase(User user) {
    return {
      if (user.pseudo != null) "name": u,
      if (user.country != null) "state": state,
      if (user.mail != null) "country": country,
      if (user.pp != null) "capital": capital,
      if (user.followers != null) "population": population,
      if (user.capsules != null) "regions": regions,
      if ()
    };
  }*/
}
