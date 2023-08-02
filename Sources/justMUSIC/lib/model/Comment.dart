import 'User.dart';

class Comment {
  final String _id;
  User _user;
  String _text;
  DateTime _date;

  // Constructor
  Comment(this._id, this._user, this._text, this._date);

  // Getters and setters
  String get id => _id;

  User get user => _user;

  String get text => _text;

  set text(String value) {
    _text = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }
}
