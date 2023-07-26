class Artist {
  String _id;
  String? _name;
  String? _image;

  Artist(this._id, this._name, this._image);

  String? get id => _id;

  String? get name => _name;

  String? get image => _image;

  set image(String? value) {
    _image = value;
  }
}
