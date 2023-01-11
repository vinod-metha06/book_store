import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  final db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> topBookStream = FirebaseFirestore.instance
      .collection('books')
      // .where("type", isEqualTo: "poetry")
      .snapshots();

  Stream<QuerySnapshot> recBookStream = FirebaseFirestore.instance
      .collection('books')
      .where("type", isEqualTo: "poetry")
      .snapshots();

  Stream<QuerySnapshot> carousalBookStream = FirebaseFirestore.instance
      .collection('books')
      .where("type", isEqualTo: "historical")
      .snapshots();
}
