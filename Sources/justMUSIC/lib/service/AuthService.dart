import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart';

class AuthService {
  register(String pseudo, String email, String password) async {
    try {
      final data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = <String, dynamic>{
        "mail": email,
        "pseudo": pseudo,
        "phone_number": "",
        "picture":
            "https://media.licdn.com/dms/image/D4E03AQHvc_b89ogFtQ/profile-displayphoto-shrink_400_400/0/1665060931103?e=1695859200&v=beta&t=wVLbxqeokYiPJ13nJ3SMq97iZvcm3ra0ufWFZCSzhjg",
        "friends": []
      };

      MyApp.db
          .collection("users")
          .doc(data.user?.uid)
          .set(user)
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for that email.');
      }
    } catch (e) {
      throw (e);
    }
  }

  login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      }
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
