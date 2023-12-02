import 'package:cloud_firestore/cloud_firestore.dart';

class CapsuleService {
  Future<List<bool>> recapSevenDays(String id) async {
    List<bool> recapList = [];

    DateTime sevenDaysAgo = DateTime.now().subtract(Duration(days: 6));

    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection("capsules")
        .where("user_id", isEqualTo: id)
        .get();

    List<Map<String, dynamic>?> capsuleList = response.docs
        .map((DocumentSnapshot<Map<String, dynamic>> doc) => doc.data())
        .toList();

    for (int i = 0; i < 7; i++) {
      DateTime date = sevenDaysAgo.add(Duration(days: i));
      bool capsuleExists = capsuleList.any((post) =>
      post?["date"] != null &&
          post?["date"].toDate().year == date.year &&
          post?["date"].toDate().month == date.month &&
          post?["date"].toDate().day == date.day);

      recapList.add(capsuleExists);
    }

    return recapList;
  }

}
