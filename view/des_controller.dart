import 'package:cloud_firestore/cloud_firestore.dart';

class AlleventsController {
  Stream<QuerySnapshot> getAlleventsStream() {
    return FirebaseFirestore.instance.collection('categories').snapshots();
  }
}

// class AlleventDetailsController {
//   Stream<QuerySnapshot> getAlleventDetailsStream(String reference) {
//     return FirebaseFirestore.instance
//         .collection('categories')
//         .doc(reference)
//         .collection('allevents')
//         .snapshots();
//   }
// }
