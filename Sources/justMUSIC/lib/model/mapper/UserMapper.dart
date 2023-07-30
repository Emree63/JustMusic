import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:justmusic/model/User.dart';

class UserMapper {
  static User toModel(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return User(
        snapshot.id,
        data?["unique_id"] ?? "",
        data?["country"] ?? "",
        data?["mail"] ?? "",
        data?["profilePicture"] ?? "",
        data?["followers"] ?? 0,
        data?["nbCapsules"] ?? 0,
        data?["followed"] ?? 0,
        data?['friends'] is List<User> ? List.from(data?['friends']) : []);
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
