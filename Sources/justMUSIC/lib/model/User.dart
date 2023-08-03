class User {
  final String _id;
  String _pseudo;
  String _uniquePseudo;
  String _mail;
  String _pp;
  String _token;
  List<String> _followers;
  int _capsules;
  List<String> _followed;

  // Constructor
  User(this._id, this._pseudo, this._uniquePseudo, this._mail, this._pp,
      this._token, this._followers, this._capsules, this._followed);

  //Getters and setters
  String get id => _id;

  String get pseudo => _pseudo;

  set pseudo(String value) {
    _pseudo = value;
  }

  String get uniquePseudo => _uniquePseudo;

  set uniquePseudo(String value) {
    _uniquePseudo = value;
  }

  String get mail => _mail;

  set mail(String value) {
    _mail = value;
  }

  String get pp => _pp;

  set pp(String value) {
    _pp = value;
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }

  int get capsules => _capsules;

  set capsules(int value) {
    _capsules = value;
  }

  List<String> get followed => _followed;

  set followed(List<String> value) {
    _followed = value;
  }

  List<String> get followers => _followers;

  set followers(List<String> value) {
    _followers = value;
  }
}
