import 'package:justmusic/services/NotificationService.dart';

Future<void> main() async {
  var notif = NotificationService();
  await notif.sendPushMessage("cAJAJw_aR7yPQbFTMS-r6H:APA91bEZs34Ab3-xSYeIGykHrxD5pRj-OyODaEcNBPtds1eLzEH0uzFkzCSQY7BvZQHEFPfeHSN7nri4webskXbu1zzgwe9NIdPagsc6IHaouuewWqWd9V7ucTeDeYt1Sbby4-pb6jtA", "Just Music", "Vien voir les nouveautés");
}