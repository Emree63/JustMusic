import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:justmusic/exceptions/user_exception.dart';
import '../main.dart';

class AuthService {
  Future<void> addUserToFirestore(
      UserCredential userCredential, String pseudo, String email) async {
    var token;
    if (!kIsWeb) {
      token = await FirebaseMessaging.instance.getToken();
    } else {
      token = "empty";
    }

    String uniqueId = await generateUniqueId(pseudo);

    final user = <String, dynamic>{
      "mail": email,
      "pseudo": pseudo,
      "unique_id": uniqueId,
      "followed": [],
      "nbCapsules": 0,
      "followers": [],
      "token_notify": token,
      "musics_likes": [],
      "picture":
          "https://firebasestorage.googleapis.com/v0/b/justmusic-435d5.appspot.com/o/justMusicDefaultImage.png?alt=media&token=020d0fcb-b7df-4d4d-b380-e99597293fcc"
    };

    try {
      await MyApp.db
          .collection("users")
          .doc(userCredential.user?.uid)
          .set(user);
      print("User Added");
    } catch (error) {
      print("Failed to add user: $error");
    }
  }

  Future<void> register(String pseudo, String email, String password) async {
    try {
      final data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await addUserToFirestore(data, pseudo, email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('Mot de passe trop court');
      } else if (e.code == 'email-already-in-use') {
        throw ('Mail déjà utilisé');
      } else if (e.code == 'invalid-email') {
        throw ('Mauvais format de mail');
      }
      rethrow;
    }
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final user =
        await MyApp.db.collection("users").doc(userCredential.user?.uid).get();

    if (!user.exists) {
      await addUserToFirestore(
          userCredential,
          userCredential.user?.displayName?.toLowerCase().replaceAll(' ', '') ?? "user",
          userCredential.user?.email ?? "");
      throw UserException("user-created", "L'utilisateur vien d'être créé");
    }

    throw UserException("user-already-exist", "L'utilisateur existe déjà");
  }

  Future<String> generateUniqueId(String pseudo) async {
    String uniqueId = '$pseudo#0001';
    int suffix = 1;
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection("users");
    final QuerySnapshot querySnapshot =
        await usersCollection.where('pseudo', isEqualTo: pseudo).get();

    querySnapshot.docs.forEach((snapshot) {
      suffix++;
      uniqueId = '$pseudo#${suffix.toString().padLeft(4, '0')}';
    });

    return uniqueId;
  }

  login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('Mail incorrect');
      } else if (e.code == 'wrong-password') {
        throw ('Mot de passe incorrect');
      } else if (e.code == 'invalid-email') {
        throw ('Format de mail incorrect');
      } else if (e.code == 'too-many-requests') {
        throw ('L\'accès à ce compte a été temporairement désactivé en raison de nombreuses tentatives de connexion infructueuses. Réessayer plus tard.');
      }
      rethrow;
    }
  }

  signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await FirebaseAuth.instance.signOut();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }
  }

  Future<void> delete() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      await MyApp.db
          .collection("users")
          .doc(currentUser?.uid)
          .delete()
          .then((value) => print("Firestore deleted user"))
          .catchError(
              (error) => print("Error deleting user from Firestore: $error"));

      await currentUser?.delete();
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw ('Please log in again to delete your account');
      }
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
