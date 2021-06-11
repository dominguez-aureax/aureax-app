import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseReference {
  // firestore which contains all collections
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // collection references
  late CollectionReference userCollection;
  late CollectionReference companyCollection;

  DatabaseReference() {
    userCollection = _firestore.collection('users');
    companyCollection = _firestore.collection('companies');
  }

  Future<void> addClient(
    String userId,
    String email,
    String password,
    String name,
  ) {
    return userCollection
        .doc(userId)
        .set({
          'name': name,
          'email': email,
          'password': password,
        })
        .then((value) => debugPrint('New User - $name'))
        .catchError((error) => debugPrint('Failed to add user: $error'));
  }

  Stream getClient(String userId) {
    return _firestore.collection('users').doc(userId).snapshots();
  }
}
