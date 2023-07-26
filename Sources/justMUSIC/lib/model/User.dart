class User {
  final int _id;
  String _pseudo;
  String _country;
  String _mail;
  String _pp;
  List<User> friends = [];

  // Constructor
  User(this._id, this._pseudo, this._country, this._mail, this._pp);

  //Getters and setters
  int get id => _id;

  String get pseudo => _pseudo;

  set pseudo(String value) {
    _pseudo = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String get mail => _mail;

  set mail(String value) {
    _mail = value;
  }

  String get pp => _pp;

  set pp(String value) {
    _pp = value;
  }
}
