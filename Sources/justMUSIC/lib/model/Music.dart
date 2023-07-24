class Music {
  final int _id;
  String _title;
  String _cover;
  String _singer;
  DateTime _date;

  // Constructor
  Music(this._id, this._title, this._cover, this._singer, this._date);

  //Getters and setters
  int get id => _id;

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get cover => _cover;

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  String get singer => _singer;

  set singer(String value) {
    _singer = value;
  }

  set cover(String value) {
    _cover = value;
  }
}
