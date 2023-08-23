import 'dart:convert';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../values/keys.dart';

class NotificationService {
  sendPushMessage(String token, String title, String body) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=$keyApiFirebase'
          },
          body: jsonEncode(<String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
            },
            "to": token,
          }));
    } catch (e) {
      print("error push notification: ${e.toString()}");
    }
  }

  sendNotifyComment(String token, String text) async {
    var pseudo = MyApp.userViewModel.userCurrent.pseudo;
    await sendPushMessage(token, "$pseudo a commenté votre capsule", "$text");
  }

  sendNotifyLike(String token, int nbLikes) async {
    var pseudo = MyApp.userViewModel.userCurrent.pseudo;
    await sendPushMessage(token, "$pseudo a aimé votre capsule", "Votre capsule a été aimé $nbLikes fois.");
  }

  sendNotifyFriend(String token) async {
    var pseudo = MyApp.userViewModel.userCurrent.pseudo;
    await sendPushMessage(token, "$pseudo vous suit.", "Il pourra à présent voir votre activité dans son Feed \"Mes Amis\".");
  }
}
