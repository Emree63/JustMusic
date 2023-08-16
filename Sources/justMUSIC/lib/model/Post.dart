import 'package:tuple/tuple.dart';

import 'Music.dart';
import 'User.dart';

class Post {
  final String _id;
  final User _user;
  String? _description;
  late Music _music;
  Tuple2<String?,String?> _location;
  List<String> _likes;
  String? _selfie;
  DateTime _date;

  // Constructor
  Post(this._id, this._user, this._description, this._location,
      this._likes, this._selfie, this._date);

  //Getters and setters
  String get id => _id;

  User get user => _user;

  String? get description => _description;

  set description(String? value) {
    _description = value;
  }

  Music get music => _music;

  set music(Music value) {
    _music = value;
  }

  Tuple2<String?, String?> get location => _location;

  set location(Tuple2<String?, String?> value) {
    _location = value;
  }

  List<String> get likes => _likes;

  set likes(List<String> value) {
    _likes = value;
  }

  String? get selfie => _selfie;

  set selfie(String? value) {
    _selfie = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }
}
