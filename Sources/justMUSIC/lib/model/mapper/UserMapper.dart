import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:justmusic/model/User.dart';

class UserMapper {
  static User toModel(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return User(
        data?["uid"],
        data?["pseudo"],
        data?["country"],
        data?["mail"],
        data?["profilePicture"],
        data?["followers"] as int,
        data?["nbCapsules"] as int,
        data?["followed"] as int,
        data?['friends'] is Iterable ? List.from(data?['friends']) : []);
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
