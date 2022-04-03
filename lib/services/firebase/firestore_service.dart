import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference<Map<String, dynamic>> users =
    firestore.collection('users');
