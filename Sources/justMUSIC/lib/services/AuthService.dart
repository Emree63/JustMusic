import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart';

class AuthService {
  register(String pseudo, String email, String password) async {
    try {
      final data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uniqueId = await generateUniqueId(pseudo);

      final user = <String, dynamic>{
        "mail": email,
        "pseudo": pseudo,
        "unique_id": uniqueId,
        "followed": [],
        "nbCapsules": 0,
        "followers": [],
        "picture":
            "https://firebasestorage.googleapis.com/v0/b/justmusic-435d5.appspot.com/o/justMusicDefaultImage.png?alt=media&token=020d0fcb-b7df-4d4d-b380-e99597293fcc"
      };

      MyApp.db
          .collection("users")
          .doc(data.user?.uid)
          .set(user)
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
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

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
