class User {
  final String _id;
  String _pseudo;
  String _country;
  String _mail;
  String _pp;
  int _followers;
  int _capsules;
  int _followed;
  List<User> friends = [];

  // Constructor
  User(this._id, this._pseudo, this._country, this._mail, this._pp,
      this._followers, this._capsules, this._followed, this.friends);

  //Getters and setters
  String get id => _id;

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

  int get capsules => _capsules;

  set capsules(int value) {
    _capsules = value;
  }

  int get followed => _followed;

  set followed(int value) {
    _followed = value;
  }

  int get followers => _followers;

  set followers(int value) {
    _followers = value;
  }
}
