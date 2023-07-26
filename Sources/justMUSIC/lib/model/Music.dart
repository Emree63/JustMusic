import 'Artist.dart';

class Music {
  final String _id;
  String? _title;
  String? _cover;
  String? _previewUrl;
  DateTime? _date;
  List<Artist> _artists;

  // Constructor
  Music(this._id, this._title, this._cover, this._previewUrl, this._date,
      this._artists);

  //Getters and setters
  String? get id => _id;

  String? get title => _title;

  set title(String? value) {
    _title = value;
  }

  String? get cover => _cover;

  set cover(String? value) {
    _cover = value;
  }

  String? get previewUrl => _previewUrl;

  set previewUrl(String? value) {
    _previewUrl = value;
  }

  DateTime? get date => _date;

  set date(DateTime? value) {
    _date = value;
  }

  List<Artist> get artists => _artists;

  set artists(List<Artist> value) {
    _artists = value;
  }
}
