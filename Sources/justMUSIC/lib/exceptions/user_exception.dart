class UserException implements Exception {
  String code;
  String description;

  UserException(this.code,this.description);
}