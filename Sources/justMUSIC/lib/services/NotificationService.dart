import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  sendPushMessage(String token, String title, String body) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAA56TmIPg:APA91bFeKMr_i6CbUuuUdFI1XkdaNE2A7OVHzxrPIsOSlDfhR6qzZwof7JNGxthWUKj1dRHQMheWNYaLbf3AtXUp9o4DX_gB2073yR4urqUEh9CjvnxVws_9g1cWMgmFS3EpaQEA3icC'
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
      print("error push notification");
    }
  }
}
