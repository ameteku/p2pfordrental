import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreBaseRepo {
  static FirebaseFirestore db() => FirebaseFirestore.instance;
}
