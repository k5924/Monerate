import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/utilities/export.dart';

class DatabaseProvider {
  final String uid;
  late ExceptionsFactory exceptionsFactory;
  late UserModel userModel;

  DatabaseProvider({required this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createNewUser() async {
    userModel = UserModel();
    await usersCollection.doc(uid).set(
          userModel.toMap(),
        );
  }

  Future<UserModel> getProfile() async {
    await usersCollection.doc(uid).get().then((value) {
      // ignore: cast_nullable_to_non_nullable
      userModel = UserModel.fromMap(value.data() as Map<String, dynamic>);
    });
    return userModel;
  }
}
