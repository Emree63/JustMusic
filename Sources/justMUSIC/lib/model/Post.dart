class Post {
  final int _id;
  final int _idUser;
  String? _description;
  String _idMusic;
  String _location;
  int _nblikes;
  String? _selfie;
  DateTime _date;

  // Constructor
  Post(this._id, this._idUser, this._description, this._idMusic, this._location,
      this._nblikes, this._selfie, this._date);

  //Getters and setters
  int get id => _id;

  int get idUser => _idUser;

  String? get description => _description;

  set description(String? value) {
    _description = value;
  }

  String get idMusic => _idMusic;

  set idMusic(String value) {
    _idMusic = value;
  }

  String get location => _location;

  set location(String value) {
    _location = value;
  }

  int get nblikes => _nblikes;

  set nblikes(int value) {
    _nblikes = value;
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
