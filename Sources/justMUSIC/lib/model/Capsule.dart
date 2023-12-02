import 'package:tuple/tuple.dart';

import 'Music.dart';

class Post {
  final String _id;
  late Music _music;
  Tuple2<String?,String?> _location;
  DateTime _date;

  // Constructor
  Post(this._id, this._location, this._date);

  //Getters and setters
  String get id => _id;

  Music get music => _music;

  set music(Music value) {
    _music = value;
  }

  Tuple2<String?, String?> get location => _location;

  set location(Tuple2<String?, String?> value) {
    _location = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }
}
