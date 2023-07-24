class Comment {
  final int _id;
  String _text;
  DateTime _date;
  List<Comment> comments = [];

  // Constructor
  Comment(this._id, this._text, this._date);

  // Getters and setters
  int get id => _id;

  String get text => _text;

  set text(String value) {
    _text = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }
}
