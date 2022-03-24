import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/utilities/export.dart';

class DatabaseProvider {
  final FirebaseFirestore db;
  late ExceptionsFactory exceptionsFactory;
  late UserModel userModel;
  late BalanceModel balanceModel;

  DatabaseProvider({required this.db});

  late CollectionReference usersCollection = db.collection('users');

  late CollectionReference balanceCollection = db.collection('balances');

  Future<void> createNewUser({required String uid}) async {
    userModel = UserModel();
    await usersCollection.doc(uid).set(
          userModel.toMap(),
        );
  }

  Future<UserModel> getProfile({required String uid}) async {
    await usersCollection.doc(uid).get().then((value) {
      // ignore: cast_nullable_to_non_nullable
      userModel = UserModel.fromMap(value.data() as Map<String, dynamic>);
    });
    return userModel;
  }

  Future<void> updateProfile({
    required UserModel profileData,
    required String uid,
  }) async {
    userModel = profileData;
    await usersCollection.doc(uid).update(userModel.toMap());
  }

  Future<void> addBalance({
    required String name,
    required String symbol,
    required String type,
    required String amount,
    required String price,
    required String uid,
  }) async {
    balanceModel = BalanceModel(
      amount: amount,
      name: name,
      price: price,
      symbol: symbol,
      type: type,
      userID: uid,
    );
    await balanceCollection.add(balanceModel.toMap());
  }

  Future<String> getBalanceID({
    required BalanceModel balanceModel,
  }) async {
    final QuerySnapshot query = await balanceCollection
        .where('userID', isEqualTo: balanceModel.userID)
        .where('type', isEqualTo: balanceModel.type)
        .where('symbol', isEqualTo: balanceModel.symbol)
        .where('price', isEqualTo: balanceModel.price)
        .where('name', isEqualTo: balanceModel.name)
        .where('amount', isEqualTo: balanceModel.amount)
        .get();
    final QueryDocumentSnapshot documentSnapshot = query.docs[0];
    final DocumentReference documentReference = documentSnapshot.reference;
    return documentReference.id;
  }

  Future<List<String>> getMultipleBalanceIDs({
    required BalanceModel balanceModel,
  }) async {
    final QuerySnapshot query = await balanceCollection
        .where('userID', isEqualTo: balanceModel.userID)
        .where('type', isEqualTo: balanceModel.type)
        .where('symbol', isEqualTo: balanceModel.symbol)
        .get();
    final documentSnapshots = query.docs;
    final List<String> documentIDs = [];
    for (final QueryDocumentSnapshot document in documentSnapshots) {
      documentIDs.add(document.reference.id);
    }
    return documentIDs;
  }

  Future<void> updateBalance({
    required String documentID,
    required BalanceModel oldBalance,
    required String amount,
    required String price,
  }) async {
    balanceModel = BalanceModel(
      amount: amount,
      name: oldBalance.name,
      price: price,
      symbol: oldBalance.symbol,
      type: oldBalance.type,
      userID: oldBalance.userID,
    );
    await balanceCollection.doc(documentID).update(balanceModel.toMap());
  }

  Future<void> removeBalance({
    required String documentID,
  }) async {
    await balanceCollection.doc(documentID).delete();
  }

  CollectionReference<Object?> getBalanceCollection() {
    return balanceCollection;
  }
}
