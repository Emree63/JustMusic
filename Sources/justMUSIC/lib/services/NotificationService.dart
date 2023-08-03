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
    await sendPushMessage(
        token, "Nouveau message", "$pseudo à réagi à votre post,\"$text\".");
  }
}
