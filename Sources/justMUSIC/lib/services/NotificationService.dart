import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final token = await _firebaseMessaging.getToken();
    print("Grrrpaw:"+token!);
    //FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}