import 'dart:io';

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
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  User get userCurrent => _userCurrent;

  set userCurrent(User value) {
    _userCurrent = value;
  }

  // Constructor

  UserViewModel();

  // Methods
  Future<User?> getUser(String id) async {
    final user = await MyApp.db.collection("users").doc(id).get();
    return UserMapper.toModel(user);
  }

  login(String pseudo, String password) async {
    try {
      var token;
      await _authService.login(pseudo, password);
      await updateUserCurrent();
      if (!kIsWeb) {
        token = await FirebaseMessaging.instance.getToken();
        if (_userCurrent.token != token) {
          _userService.updateTokenNotify(_userCurrent.id, token);
          _userCurrent.token = token;
        }
      }
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
      await _authService.register(pseudo.toLowerCase(), email, password);
      await updateUserCurrent();
    } catch (e) {
      rethrow;
    }
  }

  signInWithGoogle() async {
    try {
      await _authService.signInWithGoogle();
      await updateUserCurrent();
    } catch (e) {
      print(e);
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

  logout() async {
    await _authService.signOut();
  }

  delete() async {
    await _authService.delete();
  }

  bool isFriend(String id) {
    return _userCurrent.followed.contains(id);
  }

  updateImage(File pp) async {
    try {
      await _userService.updateImage(pp);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  updatePseudo(String pseudo) async {
    try {
      await _userService.updatePseudo(pseudo);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
