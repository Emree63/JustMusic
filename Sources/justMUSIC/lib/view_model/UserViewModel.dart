import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:justmusic/services/AuthService.dart';
import 'package:justmusic/services/UserService.dart';

import '../model/User.dart';
import '../model/mapper/UserMapper.dart';
import '../main.dart';

class UserViewModel {
  late User _userCurrent;
  final AuthService authService = AuthService();
  final UserService _userService = UserService();

  User get userCurrent => _userCurrent;

  set userCurrent(User value) {
    _userCurrent = value;
  } // Constructor

  UserViewModel();

  // Methods
  Future<User?> getUser(String id) async {
    final user = await MyApp.db.collection("users").doc(id).get();
    return UserMapper.toModel(user);
  }

  login(String pseudo, String password) async {
    try {
      var token;
      await authService.login(pseudo, password);
      final user = await MyApp.db
          .collection("users")
          .doc(firebase_auth.FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (!kIsWeb) {
        token = await FirebaseMessaging.instance.getToken();
        if (MyApp.userViewModel.userCurrent.token != token) {
          _userService.updateTokenNotify(
              MyApp.userViewModel.userCurrent.id, token);
          MyApp.userViewModel.userCurrent.token = token;
        }
      }
      User data = UserMapper.toModel(user);
      _userCurrent = data;
    } catch (e) {
      rethrow;
    }
  }

  bool _isAlphaNumeric(String input) {
    final RegExp alphaNumericRegExp = RegExp(r'^[a-zA-Z0-9]+$');
    return alphaNumericRegExp.hasMatch(input);
  }

  updateUserCurrent() async {
    try {
      final user = await MyApp.db
          .collection("users")
          .doc(firebase_auth.FirebaseAuth.instance.currentUser?.uid)
          .get();
      User data = UserMapper.toModel(user);
      _userCurrent = data;
    } catch (e) {
      print(e);
    }
  }

  register(String pseudo, String password, String email) async {
    if (!_isAlphaNumeric(pseudo)) {
      throw ("Le pseudo doit contenir seulement des lettres et des chiffres");
    }

    try {
      await authService.register(pseudo.toLowerCase(), email, password);
      final user = await MyApp.db
          .collection("users")
          .doc(firebase_auth.FirebaseAuth.instance.currentUser?.uid)
          .get();
      User data = UserMapper.toModel(user);
      _userCurrent = data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User>> getUsersByUniqueId(String uniqueId) async {
    try {
      var response =
          await _userService.getUsersByIdUnique(uniqueId.toLowerCase());
      var users = response.map((value) {
        return UserMapper.toModel(value);
      }).toList();
      return users;
    } catch (e) {
      return [];
    }
  }

  addOrDeleteFriend(String id) async {
    try {
      await _userService.addOrDeleteFriend(id);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  logout() {
    authService.signOut();
  }

  bool isFriend(String id) {
    return _userCurrent.followed.contains(id);
  }
}
