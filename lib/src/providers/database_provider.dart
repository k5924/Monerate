import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monerate/src/utilities/export.dart';

class DatabaseProvider {
  final String uid;
  late ExceptionsFactory exceptionsFactory;

  DatabaseProvider({required this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createNewUser() async {
    await usersCollection.doc(uid).set({
      'firstName': null,
      'lastName': null,
      'userType': null,
    });
  }
}
