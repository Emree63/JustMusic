import '../model/User.dart';

class UserViewModel {
  User _userCurrent = User(
      1, "MelinaShow", "France", "test@gmail.com", "zezrzrzr", 5, 12, 114, []);

  User get userCurrent => _userCurrent;

  set userCurrent(User value) {
    _userCurrent = value;
  } // Constructor

  UserViewModel();

  // Methods
  User getUser(int id) {
    throw new Error();
  }
}
